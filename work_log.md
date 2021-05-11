# 作業記録

## github action

構文は[ここ](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepswith)を読んだ。

## gh コマンド

githubのcli操作をできるようにするツール。
github actionの実行状態も見れるらしいので使ってみる。

https://cli.github.com/manual/ を見ながらやる。

### インストール

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % brew install gh

...

==> Caveats
zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> Summary
🍺  /usr/local/Cellar/gh/1.9.2: 89 files, 28.5MB
(python-webapp-CCg2Futh-py3.9)
```

zsh completionsとワード入っているので補完が効く？
そのままでは効かなかった。
[こちら](https://ja.stackoverflow.com/questions/48678/zsh-%E3%81%A7-brew-%E3%81%A7%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%95%E3%82%8C%E3%81%A6%E3%81%84%E3%82%8B-zsh-%E8%A3%9C%E5%AE%8C%E3%82%92%E4%B8%80%E6%8B%AC%E3%81%A7%E5%88%A9%E7%94%A8%E5%8F%AF%E8%83%BD%E3%81%AB%E3%81%97%E3%81%9F%E3%81%84)を参考に設定したらできた。

### 認証

https://cli.github.com/manual/gh_auth_login を見ながら。

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % gh auth login
? What account do you want to log into? GitHub.comThe value of the GITHUB_TOKEN environment variable is being used for authentication.
To have GitHub CLI store credentials instead, first clear the value from the environment.
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template %
```

githubとgithub enterpriseとどっちにログインしたいの？
と聞かれて、githubとしたらそのまま終わった。
以前github のアプリを入れていたからだろう。GIHUB_TOKENという環境変数があるのでだめらしい。

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % gh auth status
github.com
  X github.com: authentication failed
  - The github.com token in GITHUB_TOKEN is no longer valid.

(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template %
```

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % unset GITHUB_TOKEN
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template %
```

unsetで環境変数を削除して再度ログイン

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % gh auth login
? What account do you want to log into? GitHub.com? What is your preferred protocol for Git operations? SSH? Upload your SSH public key to your GitHub account? /Users/vaivailx/.ssh/id_rsa.pub
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: 4197-CD2B
- Press Enter to open github.com in your browser...
✓ Authentication complete. Press Enter to continue...

- gh config set -h github.com git_protocol ssh
✓ Configured git protocol
✓ Uploaded the SSH key to your GitHub account: /Users/vaivailx/.ssh/id_rsa.pub
✓ Logged in as 1021ky
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template %
```

いけた。
やりたかったgithub actionの状態を取得してみる。

```zsh
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template % gh workflow list
GitHub Actions for CD  active  8939959
GitHub Actions for CI  active  8939960
(python-webapp-CCg2Futh-py3.9) vaivailx@MacBook-Pro-2 python_webapp_template %
```

いけた！

これで、pushあとにいちいちブラウザを見なくていい！