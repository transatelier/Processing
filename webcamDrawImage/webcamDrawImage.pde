//la bibliothèque "Video | GStreamer-based video library for Processing" doit être préalablement intégrée à processing (Sketch/Importer une librairie/Ajouter une librairie...)
import processing.video.*;

Capture cam;
float threshold = 125; // seuil de luminosité
int camNumber = 0; // numéro de la webcam
int camFps = 5;  // image par seconde de la webcam.

float imgPixels;
float imgWhitePixels = 0;
boolean camReading;

void setup() {
  // taille et cadence de la webcam
  size(640, 480);
  frameRate(camFps);
  
  String[] cameras = Capture.list();
  imgPixels = width*height;
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    // renvoie tous les périphériques vidéo avec leurs résolutions et fps
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    cam = new Capture(this, cameras[camNumber]);
    cam.start();     
  }
  
}

// Fonction de traitement de l'image vidéo pixels par pixels.
void CamReadWhitePixel() {
  camReading = true;
  cam.loadPixels();
    
  for (int x = 0; x < cam.width; x++) {
    for (int y = 0; y < cam.height; y++ ) {
      int loc = x + y*cam.width;
      // Test de luminosité des pixels par rapport au seuil
      if (brightness(cam.pixels[loc]) > threshold) {
        imgWhitePixels  += 1;
      }
    }
  }
  
  //Affichage du pourcentage de pixels blancs (clairs)
  String screenText = "Pixel blanc: " + (imgWhitePixels*100)/imgPixels + "%";
  noStroke();
  fill(200);  // Set fill to white
  rect(0, height-25, width, 25);
  fill(255);
  textSize(15);
  text(screenText, 5, height-22, width, 25);
  imgWhitePixels = 0;
  camReading = false;
}

// Fonction d'affichage de l'image vidéo
void draw() {
  if(cam.available()){
    cam.read();
    if(camReading == false) {
      image(cam, 0, 0, width, height);
      CamReadWhitePixel();
    }
  }
}