git add .
# message: update-{date}
git commit -m "update-$(date +%Y-%m-%d)"

black .
git add .
# message: update-{date}
git commit -m "update-$(date +%Y-%m-%d)-black"

git push