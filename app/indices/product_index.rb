ThinkingSphinx::Index.define :product, with: :active_record do
  indexes name, infixes: true
end
