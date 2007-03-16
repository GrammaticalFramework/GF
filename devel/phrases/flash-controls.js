function getFlashMovieObject(movieName) {
  if (window.document[movieName]) {
      return window.document[movieName];
  }
  if (document.embeds && document.embeds[movieName]) {
      return document.embeds[movieName]; 
  } else {
      return document.getElementById(movieName);
  }
}

function flashPlay(movieName) {
  getFlashMovieObject(movieName).Play();
}

function flashPause(movieName) {
  getFlashMovieObject(movieName).StopPlay();
}
