module SignInSupport
  def sign_in(user)
    visit root_path
    # ユーザー情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押すとuser#indexへ遷移することを確認する
    find('input[name="commit"]').click
    sleep 3
    expect(page).to have_current_path(users_path)
  end
end