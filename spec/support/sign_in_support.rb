module SignInSupport
  def sign_in(user)
    visit root_path
    # ログインと新規登録のボタンが存在する
    expect(page).to have_content('ログイン')
    expect(page).to have_content('新規登録')
    # ログインページへ遷移する
    find('.login_btn_post').click
    sleep 1
    expect(page).to have_current_path(new_user_session_path)
    # ユーザー情報を入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンを押すとuser#indexへ遷移することを確認する
    find('input[name="commit"]').click
    sleep 3
    expect(page).to have_current_path(users_path)
  end
end