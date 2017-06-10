/* global $ */
/* global createjs */

var stage;

$(function(){

  stage = new createjs.Stage("canvas");
  
  var word = WordLeaning.getWord();
  DrawCanvas.drawWord(word);
  
});

var WordLeaning = {};
WordLeaning.getWord = function(){
  //ajaxの処理を入れていくんだよ。
  return "word"
}

WordLeaning.getImages = function(){
  //ajaxの処理を入れていくんだよ。
  return "word"
}

var DrawCanvas = {};

DrawCanvas.drawWord = function(word){
  //テキストデータの作成
  var wordObj = new createjs.Text(word, "28px 'Open Sans', 'Helvetica Neue', Helvetica, Arial, sans-serif", "DarkRed");
  //座標調整
  wordObj.textAlign = "center";
  wordObj.x = stage.canvas.width / 2;
  wordObj.y = 50;
  //ステージに追加
  stage.addChild(wordObj);
  //更新
  stage.update();
}

