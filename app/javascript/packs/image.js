// 画像のプレビュー表示
/* global $*/
$(function(){
  // <div class='image'>の直後の兄弟要素（今回の場合は<div class='prevImageBox'>がそれに該当）を取得。
  const prevImage = $('.image').next();

  // プレビュー表示部分のhtml
  function buildHTML(id,image) {
    let html = `<div class="prevImageBox">
                  <div class="upper-box">
                    <img src=${image} alt="preview">
                  </div>
                  <div class="lower-box">
                    <div class="delete-box">
                      <div class="delete-btn" data-delete-id= ${id}>画像を選びなおす</div>
                    </div>
                  </div>
                </div>`
    return html;
  }

  // ===========================================
  // imageInputの値が変更したとき(画像が選択された時）の処理
  // ===========================================
  $(document).on('change', '.imageInput', function() {
    //imageInputのidを取得
    let id = $(this).attr('id');
    //選択したfile（画像）のオブジェクトを取得
    let file = this.files[0];
    // PC内にあるファイルをアプリケーションに非同期で読み込む
    let reader = new FileReader();
    //readAsDataURLで指定したFileオブジェクトを読み込む
    reader.readAsDataURL(file);
    //読み込み時に発火するイベント
    reader.onload = function() {
      // 直前に実行されたイベント（imageファイルの読み込み）を変数imageに代入
      let image = this.result;
      //htmlを作成
      let html = buildHTML(id,image);
      //<div class='prevImageBox>にプレビュー画像を追加
      $(prevImage).append(html);
      //画像が選択された状態（プレビュー画像表示中）だと、画像選択フォームを隠す
      $('.imageInput').hide();
    }
  });

  // ==================================
  //   プレビュー画像を削除する場合の処理
  // ==================================
  $(document).on('click', '.delete-btn', function() {
    let id = $(this).attr('data-delete-id')
    //画像を消去
    $(this).parent().parent().parent().remove();
    //画像選択フォームの中身を空にする
    $('.imageInput').val("");
    //画像選択フォームを表示
    $('.imageInput').show();
  });
});