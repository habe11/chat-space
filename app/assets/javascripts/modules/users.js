$(function(){

  function addUser(user) {
    let html = `
                <div class="ChatMember clearfix">
                  <p class="ChatMember__name">${user.name}</p>
                  <div class="ChatMember__add ChatMember__button" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>
                `;
    $("#UserSearchResult").append(html);
    // ユーザー検索結果IDに結果候補を追加
  }
  function addNoUser() {
    let html = `
                <div class="ChatMember clearfix">
                  <p class="ChatMember__name">ユーザーが見つかりません</p>
                </div>
                `;
    $("#UserSearchResult").append(html);
    // ユーザー検索結果IDに結果候補を追加
  }

  function addMember(name, id) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${name}</p>
                  <input name="group[user_ids][]" type="hidden" value="${id}" />
                  <div class="ChatMember__remove ChatMember__button">削除</div>
                </div>
                `;
    $(".ChatMembers").append(html);
  }

  $("#UserSearch__field").on("keyup", function() {
    // keyup ＝ 文字の入力
    let input = $("#UserSearch__field").val();
    // valメソッド ＝フォームの値を取得する時に使用するメソッド
    //フォームの値を取得して変数に代入
    // console.log(input);
    // input実行時にコンソールログ確認
    $.ajax({
      type: "GET",   //HTTPメソッド
      url: "/users",      //users_controllerの、indexアクションにリクエストの送信先を設定する
      dataType: 'json',
      data: { keyword: input },   //テキストフィールドに入力された文字を設定する
      // input変数をkeywordカラムに。
    })
    .done(function(users) {
      // console.log(users)
      $("#UserSearchResult").empty();
      //emptyメソッドで一度検索結果を空にする
      if (users.length !== 0) {
         //usersが空じゃ無い場合
        users.forEach(function(user) {
          addUser(user);
          // addUser(ユーザー追加処理)実行
        });
      } else if (input.length == 0) {
        //usersが空の場合
        return false;
      } else {
        addNoUser();
        // addNoUser(ユーザー見つかりません処理)実行
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    })
  })
  $("#UserSearchResult").on("click", ".ChatMember__add", function() {
    // 追加ボタンを押下すると親要素の情報を取得してfunctionを実行
    // console.log("OKです");
    const userName = $(this).attr("data-user-name");
    // ".ChatMember__add"に属する"data-user-name"をuserNameに代入
    const userId = $(this).attr("data-user-id");
    // ".ChatMember__add"に属する"data-user-id"をuserIdに代入
    $(this).parent().remove();
    // 親要素の削除
    addMember(userName, userId);
    // addMember(メンバー追加のHTML)を呼び出し
  })
  $(".ChatMembers").on("click", ".ChatMember__remove", function() {
    // 「削除ボタン」を「押下」すると".ChatMember__remove"の情報を取得してfunctionを実行
    $(this).parent().remove();
  });
})
