JEKYLL_ENV=production jekyll build --incremental
rsync -ra _site alphacephei.com:
