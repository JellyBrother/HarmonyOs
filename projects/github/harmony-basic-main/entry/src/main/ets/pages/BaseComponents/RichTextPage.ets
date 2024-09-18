@Entry
@Component
struct RichTextPage {
  build() {
    Column() {
      RichText(`
        <style>
          .module {
            padding: 20px;
          }
          .module-list-item {
            font-size: 80px;
          }
        </style>
        <div class="module-categories module">
          <h2 class="module-header">关于</h2>
          <div class="module-content">
            <ul class="module-list">
            <p class="module-list-item">
              <a
                href="https://www.ruanyifeng.com/blog/images/person_shot.jpg"
                onclick="window.open(
                  'http://www.ruanyifeng.com/blog/images/person2.jpg',
                  'popup',
                  'width=480,
                  height=640,
                  scrollbars=no,
                  resizable=no,
                  toolbar=no,
                  directories=no,
                  location=no,
                  menubar=no,
                  status=no,
                  left=0,
                  top=0'
                );
                return false
                "
              >
                <img src="https://www.ruanyifeng.com/blog/images/person2_s.jpg" width="400" height="530" alt="个人照片">
              </a>
            </p>
              <!--li class="module-list-item"><a href="/about.html">个人简介</a>，<a href="2015/02/turing-interview.html" target="_blank">访谈</a></li-->
              <!--li class="module-list-item">Email：<br /><a href="mailto:yifeng.ruan@gmail.com">yifeng.ruan@gmail.com</a></li-->
              <li class="module-list-item">文章：<a href="https://www.ruanyifeng.com/blog/archives.html">2126</a></li>
              <li class="module-list-item">留言：73239</li>

            </ul>
          </div>
        </div>
      `)
    }
    .height('100%')
    .width('100%')
  }
}