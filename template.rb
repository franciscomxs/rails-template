ROOT_PATH     = File.expand_path(File.join(File.dirname(__FILE__)))

FILES_PATH    = File.join(ROOT_PATH, 'files')

def copy_static_file(path)
  remove_file path
  file path, File.read(File.join(FILES_PATH, path))
end

def copy_static_directory(path)
  directory "#{FILES_PATH}/#{path}", path
end

def apply_partial(partial)
  apply "#{PARTIALS_PATH}/#{partial}.rb"
end

copy_static_file 'Dockerfile'
copy_static_file 'docker-compose.yml'
copy_static_file 'Gemfile'
copy_static_directory "spec"
copy_static_directory ".github"

route "get '/ping' => proc { |env| [200, {}, ['pong']] }"

after_bundle do
  git :init
  git add: "."
  git commit: "-a -m 'Initial commit'"
end
