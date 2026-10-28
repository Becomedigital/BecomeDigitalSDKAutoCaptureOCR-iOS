require 'xcodeproj'

root = File.expand_path(__dir__)
project = Xcodeproj::Project.new(File.join(root, 'iOSBlinkIDIntegration.xcodeproj'))
project.root_object.attributes['LastUpgradeCheck'] = '2700'
target = project.new_target(:application, 'iOSBlinkIDIntegration', :ios, '16.0')
target.product_reference.name = 'iOSBlinkIDIntegration.app'

app = project.main_group.new_group('App', 'App')
%w[AppDelegate.swift SceneDelegate.swift ViewController.swift VerificationScreen.swift].each do |name|
  target.source_build_phase.add_file_reference(app.new_file(name))
end
app.new_file('Info.plist')

{
  'Localizable.strings' => %w[en es es-419],
  'InfoPlist.strings' => %w[es es-419]
}.each do |name, locales|
  group = app.new_variant_group(name)
  locales.each do |locale|
    ref = group.new_file("#{locale}.lproj/#{name}")
    ref.name = locale
  end
  target.resources_build_phase.add_file_reference(group)
end

frameworks = project.main_group.new_group('Frameworks')
framework = frameworks.new_file('../../BDIdentityVerification.xcframework')
target.frameworks_build_phase.add_file_reference(framework)
embed = target.new_copy_files_build_phase('Embed Frameworks')
embed.dst_subfolder_spec = '10'
embed_file = embed.add_file_reference(framework)
embed_file.settings = { 'ATTRIBUTES' => %w[CodeSignOnCopy RemoveHeadersOnCopy] }

packages = {
  'https://github.com/aws-amplify/amplify-swift' => ['2.53.3', 'Amplify'],
  'https://github.com/aws-amplify/amplify-ui-swift-liveness' => ['1.4.4', 'FaceLiveness'],
  'https://github.com/microblink/blinkid-ios' => ['8002.0.2', 'BlinkIDUX']
}
packages.each do |url, (version, product_name)|
  reference = project.new(Xcodeproj::Project::Object::XCRemoteSwiftPackageReference)
  reference.repositoryURL = url
  reference.requirement = { 'kind' => 'exactVersion', 'version' => version }
  project.root_object.package_references << reference
  product = project.new(Xcodeproj::Project::Object::XCSwiftPackageProductDependency)
  product.package = reference
  product.product_name = product_name
  target.package_product_dependencies << product
  build_file = project.new(Xcodeproj::Project::Object::PBXBuildFile)
  build_file.product_ref = product
  target.frameworks_build_phase.files << build_file
  if product_name == 'BlinkIDUX'
    embedded = project.new(Xcodeproj::Project::Object::PBXBuildFile)
    embedded.product_ref = product
    embedded.settings = { 'ATTRIBUTES' => %w[CodeSignOnCopy RemoveHeadersOnCopy] }
    embed.files << embedded
  end
end

local_configuration = target.new_shell_script_build_phase('Copy local demo configuration')
local_configuration.always_out_of_date = '1'
local_configuration.shell_script = <<~'SH'
  set -eu
  for name in DemoConfiguration.plist com.become.blinkid.key.txt; do
    source_file="${PROJECT_DIR}/App/${name}"
    destination_file="${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${name}"
    if [ -f "${source_file}" ]; then
      install -m 600 "${source_file}" "${destination_file}"
    else
      rm -f "${destination_file}"
    fi
  done
SH

target.build_configurations.each do |configuration|
  configuration.build_settings.merge!({
    'PRODUCT_BUNDLE_IDENTIFIER' => 'com.example.become.integration',
    'INFOPLIST_FILE' => 'App/Info.plist',
    'GENERATE_INFOPLIST_FILE' => 'NO',
    'SWIFT_VERSION' => '5.0',
    'TARGETED_DEVICE_FAMILY' => '1',
    'IPHONEOS_DEPLOYMENT_TARGET' => '16.0',
    'CODE_SIGN_STYLE' => 'Automatic',
    'ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES' => 'YES'
  })
end
project.save
