Pod::Spec.new do |s|
  s.name             = 'Burritos'
  s.version          = '0.0.3'
  s.summary          = 'A collection of well tested Swift Property Wrappers.'
  s.description      = <<-DESC
A collection of well tested Swift Property Wrappers.
  * @AtomicWrite
  * @Clamping
  * @Copying
  * @DefaultValue
  * @DynamicUIColor
  * @Expirable
  * @LateInit
  * @Lazy
  * @LazyConstant
  * @MappingSetter
  * @Trimmed
  * @UndoRedo
  * @UserDefault
  * More coming ...
                       DESC

  s.homepage         = 'https://github.com/guillermomuntaner/Burritos'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Guillermo Muntaner' => 'guillermomp87@gmail.com' }
  s.source           = { :git => 'https://github.com/guillermomuntaner/Burritos.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/guillermomp87'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.swift_versions = ['5.0', '5.1']

  ## @AtomicWrite
  s.subspec 'AtomicWrite' do |sp|
    sp.source_files = 'Sources/AtomicWrite/*'
    sp.framework = 'Foundation'
  end

  ## @Clamping
  s.subspec 'Clamping' do |sp|
   sp.source_files = 'Sources/Clamping/*'
  end

  ## @Copying
  s.subspec 'Copying' do |sp|
    sp.source_files = 'Sources/Copying/*'
    sp.framework = 'Foundation'
  end

  ## @DefaultValue
    s.subspec 'DefaultValue' do |sp|
    sp.source_files = 'Sources/DefaultValue/*'
  end

  ## @Copying
  s.subspec 'DynamicUIColor' do |sp|
    sp.source_files = 'Sources/DynamicUIColor/*'
    sp.ios.framework = 'UIKit'
  end

  ## @EnvironmentVariable
  s.subspec 'EnvironmentVariable' do |sp|
    sp.source_files = 'Sources/EnvironmentVariable/*'
    sp.ios.framework = 'Foundation'
  end

  ## @Expirable
  s.subspec 'Expirable' do |sp|
    sp.source_files = 'Sources/Expirable/*'
    sp.framework = 'Foundation'
  end

  ## @LateInit
  s.subspec 'LateInit' do |sp|
    sp.source_files = 'Sources/LateInit/*'
  end

  ## @Lazy
  s.subspec 'Lazy' do |sp|
    sp.source_files = 'Sources/Lazy/*'
  end

  ## @LazyConstant
    s.subspec 'LazyConstant' do |sp|
    sp.source_files = 'Sources/LazyConstant/*'
  end

  ## @MappingSetter
    s.subspec 'MappingSetter' do |sp|
    sp.source_files = 'Sources/MappingSetter/*'
  end

  ## @Trimmed
  s.subspec 'Trimmed' do |sp|
    sp.source_files = 'Sources/Trimmed/*'
    sp.framework = 'Foundation'
  end

  ## @UndoRedo
  s.subspec 'UndoRedo' do |sp|
    sp.source_files = 'Sources/UndoRedo/*'
    sp.framework = 'Foundation'
  end

  ## @UserDefault
  s.subspec 'UserDefault' do |sp|
    sp.source_files = 'Sources/UserDefault/*'
    sp.framework = 'Foundation'
  end
end
