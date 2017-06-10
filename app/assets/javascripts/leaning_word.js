/* global $ */
/* global createjs */

var stage;
var count = 0;
var correctWord = "";

$(function(){

  stage = new createjs.Stage("canvas");
  
  // 単語を取得し、画面描画。
  WordLeaning.nextWord();
  
});

var WordLeaning = {};
WordLeaning.nextWord = function(){

  stage.removeAllChildren();
  stage.update();

  WordLeaning.getWord(
    $("#id").html(),
    count,
    function(word){
      DrawCanvas.drawWord(word);
      DrawCanvas.drawImages(word);
      DrawCanvas.drawButtons(["a","b","c"])
    }
  );
}
WordLeaning.getWord = function(id,num,callback){
  $.get(
    "/leaning_word/getWord/"+id + "/" + num,
    function(res){
      callback(res[0].word)
      count = count + 1;
    }
  );
}

WordLeaning.getImages = function(searchWord,callback){
  $.get(
    "/leaning_word/getImages/"+searchWord,
    function(res){
      callback(res)
    }
  );
  return null
}

var DrawCanvas = {};

DrawCanvas.drawWord = function(word){
  correctWord = word;
  var wordObj = new createjs.Text(word, "28px 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif", "DarkRed");
  wordObj.textAlign = "center";
  wordObj.x = stage.canvas.width / 2;
  wordObj.y = 50;
  stage.addChild(wordObj);
  stage.update();
}

DrawCanvas.drawImages = function(word){
  //検索データを取得
  WordLeaning.getImages(
    word,
    function(response){
      //console.log()
      //stage.update();
      response.hits.forEach(function(image,index){
        var bmp = new createjs.Bitmap(image.previewURL);
        bmp.x = 10 + index * 100;
        bmp.y = 120;
        stage.addChild(bmp);
      });
      stage.update();
      setTimeout(function(){
        stage.update();
      },1000)
    }
  );
}

DrawCanvas.drawButtons = function(words){
  var buttons = [];
  words.forEach(function(word,index){
    var btn = createButton( word , 150, 40, "#0275d8");
    btn.x = 50 + 180 * index;
    btn.y = 300;
    btn.addEventListener("click", function(event){
      // console.log(event.currentTarget.name);
      if ( event.currentTarget.name == correctWord ) {
      }
      WordLeaning.nextWord();
    });
    stage.addChild( btn );
  });
  stage.update();
}

function createButton(text, width, height, keyColor) {
  // ボタン要素をグループ化
  var button = new createjs.Container();
  button.name = text; // ボタンに参考までに名称を入れておく(必須ではない)
  button.cursor = "pointer"; // ホバー時にカーソルを変更する
  // 通常時の座布団を作成
  var bgUp = new createjs.Shape();
  bgUp.graphics
          .setStrokeStyle(1.0)
          .beginStroke(keyColor)
          .beginFill("white")
          .drawRoundRect(0.5, 0.5, width - 1.0, height - 1.0, 4);
  button.addChild(bgUp);
  bgUp.visible = true; // 表示する
  // ロールオーバー時の座布団を作成
  var bgOver = new createjs.Shape();
  bgOver.graphics
          .beginFill(keyColor)
          .drawRoundRect(0, 0, width, height, 4);
  bgOver.visible = false; // 非表示にする
  button.addChild(bgOver);
  // ラベルを作成
  var label = new createjs.Text(text, "18px sans-serif", keyColor);
  label.x = width / 2;
  label.y = height / 2;
  label.textAlign = "center";
  label.textBaseline = "middle";
  button.addChild(label);
  // ロールオーバーイベントを登録
  button.addEventListener("mouseover", handleMouseOver);
  button.addEventListener("mouseout", handleMouseOut);
  function handleMouseOver(event) {
    bgUp.visble = false;
    bgOver.visible = true;
    label.color = "white";
  }
  function handleMouseOut(event) {
    bgUp.visble = true;
    bgOver.visible = false;
    label.color = keyColor;
  }
  return button;
}
