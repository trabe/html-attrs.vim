guard :rspec do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/.+\.rb$}) { Dir.glob('spec/*_spec.rb') }
  watch(%r{^plugin/(.+)\.vim$}) { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
end
