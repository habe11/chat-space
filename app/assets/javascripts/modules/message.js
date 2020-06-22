$(function(){
  // let reloadMessages = function() {
  //   //カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
  //   let last_message_id = $('.MessageBox:last').data("message-id");
  //   $.ajax({
  //     //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
  //     url: "api/messages",
  //     //ルーティングで設定した通りhttpメソッドをgetに指定
  //     type: 'get',
  //     dataType: 'json',
  //     //dataオプションでリクエストに値を含める
  //     data: {id: last_message_id}
  //   })
  //   .done(function(messages) {
  //      // 更新するメッセージがなかった場合は.doneの後の処理が動かないようにする
  //      if (messages.length !== 0) {
  //       //追加するHTMLの入れ物を作る
  //       let insertHTML = '';
  //       //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
  //       $.each(messages, function(i, message) {
  //         insertHTML += buildHTML(message)
  //       });
  //       //メッセージが入ったHTMLに、入れ物ごと追加
  //       $('.MessageField').append(insertHTML);
  //       //メッセージが入ったHTMLに、height0部分からスクロールできる機能を追加
  //       $('.MessageField').animate({ scrollTop: $('.MessageField')[0].scrollHeight});
  //      }
  //   })
  //   .fail(function() {
  //     alert('error');
  //   });
  //   setInterval(reloadMessages, 7000);
  // };





  function buildHTML(message){
    if ( message.image ) {
      let html =
        `<div class="chat-main__groupes__box" data-message-id=${message.id}>
          <div class="chat-main__groupes__box__group">
            <div class="chat-main__groupes__box__group__name">
              ${message.user_name}
            </div>
            <div class="chat-main__groupes__box__group__data">
              ${message.created_at}
            </div>
          </div>
          <div class="chat-main__groupes__box__content">
            <p class="Message__content">
              ${message.content}
            </p>
            <img class="Message__image" src="${message.image}">
          </div>
        </div>`
      return html;
    } else {
      let html =
      `<div class="chat-main__groupes__box" data-message-id=${message.id}>
        <div class="chat-main__groupes__box__group">
          <div class="chat-main__groupes__box__group__name">
            ${message.user_name}
          </div>
          <div class="chat-main__groupes__box__group__data">
            ${message.created_at}
          </div>
        </div>
        <div class="chat-main__groupes__box__content">
          <p class="Message__content">
            ${message.content}
          </p>
        </div>
      </div>`
      return html;
    };
  }
  $('.Form').on('submit', function(e){
    e.preventDefault();
    let formData = new FormData(this);
    let url = $(this).attr('action');
    // $(this) = onメソッドを使用しているオブジェクト = $('.Form')
    // attrメソッドによりaction属性の値を取得(検証ツールで確認してね)
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.chat-main__groupes').append(html);      
      // doneメソッド内で指定したhtml変数を指定したクラス(reder元のクラス)に追加
      $('.chat-main__groupes').animate({ scrollTop: $('.chat-main__groupes')[0].scrollHeight});
      // 指定した値の分だけanimateメソッドを利用した要素をスクロール
      $('form')[0].reset();
      // 元々のform文をリセット
      // $(".chat-main__footer__form__submit").prop("disabled", false);
      $(".chat-main__footer__form__submit").removeAttr("disabled");
      // "disabled"を".chat-main__footer__form__submit"から削除する
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
  })
})
