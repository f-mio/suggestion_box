document.addEventListener('DOMContentLoaded', function() {
  if (document.getElementById('after-image') ){
    const AfterImageList = document.getElementById('after-image-list')

    // 選択した画像を表示する関数
    const createImageHTML = (after_blob) => {
      // 画像を表示するためのdiv要素を生成
      const afterImageElement = document.createElement('div')

      afterImageElement.setAttribute('class', "after-image-element")
      let afterImageElementNum = document.querySelectorAll(".after-image-element").length

      // 表示する画像を生成
      const blobImage = document.createElement('img')
      blobImage.setAttribute('src', after_blob)
      blobImage.setAttribute('class', "attached-image")

      // ファイル選択ボタンを生成
      const afterInputHTML = document.createElement('input')
      afterInputHTML.setAttribute('id', `after-image-${afterImageElementNum}`)
      afterInputHTML.setAttribute('name', 'after[images][]')
      afterInputHTML.setAttribute('type', 'file')
      afterInputHTML.setAttribute('class', 'image-file')

      // 生成したHTMLの要素をブラウザに表示させる
      afterImageElement.appendChild(blobImage)
      if (afterImageElementNum < 2) {
        afterImageElement.appendChild(afterInputHTML)
      }
      AfterImageList.appendChild(afterImageElement)

      afterInputHTML.addEventListener('change', (e) => {
        after_file = e.target.files[0];
        after_blob = window.URL.createObjectURL(after_file);

          createImageHTML(after_blob)
      })
    }

    document.getElementById('after-image').addEventListener('change', (e) => {
      let after_file = e.target.files[0]
      let after_blob = window.URL.createObjectURL(after_file)
      createImageHTML(after_blob)
    })
  }
})