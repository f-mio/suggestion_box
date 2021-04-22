document.addEventListener('DOMContentLoaded', function() {
  if (document.getElementById('before-image') ){
    const BeforeImageList = document.getElementById('before-image-list')

    // 選択した画像を表示する関数
    const createImageHTML = (before_blob) => {
      // 画像を表示するためのdiv要素を生成
      const beforeImageElement = document.createElement('div')

      beforeImageElement.setAttribute('class', "before-image-element")
      let beforeImageElementNum = document.querySelectorAll(".before-image-element").length

      // 表示する画像を生成
      const blobImage = document.createElement('img')
      blobImage.setAttribute('src', before_blob)
      blobImage.setAttribute('class', "attached-image")

      // ファイル選択ボタンを生成
      const beforeInputHTML = document.createElement('input')
      beforeInputHTML.setAttribute('id', `before-image-${beforeImageElementNum}`)
      beforeInputHTML.setAttribute('name', 'before[images][]')
      beforeInputHTML.setAttribute('type', 'file')
      beforeInputHTML.setAttribute('class', 'image-file')

      // 生成したHTMLの要素をブラウザに表示させる
      beforeImageElement.appendChild(blobImage)
      if (beforeImageElementNum < 2) {
        beforeImageElement.appendChild(beforeInputHTML)
      }
      BeforeImageList.appendChild(beforeImageElement)

      beforeInputHTML.addEventListener('change', (e) => {
        before_file = e.target.files[0];
        before_blob = window.URL.createObjectURL(before_file);

          createImageHTML(before_blob)
      })
    }

    document.getElementById('before-image').addEventListener('change', (e) => {
      let before_file = e.target.files[0]
      let before_blob = window.URL.createObjectURL(before_file)
      createImageHTML(before_blob)
    })
  }
})