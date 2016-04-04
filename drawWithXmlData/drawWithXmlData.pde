/*  - readXmlFile.pde - processing 3.0.1 - transat@cabsii.net
    - DataArt - Generation de dessin a partir de données XML.
    - Fichier XML généré par script php sur une base de donnée de connexions IPs
    géolocalisées; stockage du fichier: /data
*/

XML xml;
XML[] cityXml;
int numCitys;
int merid;
int equat;
float zoomFact;

void setup() {
  size(1280, 960);
  background(255, 255, 255);
  
  // Definition des axes et du facteur de zoom.
  merid = width/2;
  equat = height/2;
  zoomFact = 3;
  
  //Chargement et stockage des données XML
  xml = loadXML("ipXmlFile.xml");
  cityXml = xml.getChildren("ipbases");
  numCitys = cityXml.length;
  
  //Affichage image map monde
  // drawWorldMap();
  
  
  readXML();
}

void drawWorldMap(){
  PImage map;
  map = loadImage("planisphere.png");
  int mapW = 1210;
  int mapH = 525;
  map.resize(mapW, mapH);
  float mapX = merid - mapW/2.08;
  float mapY = equat- mapH/1.58;
  image(map,mapX,mapY);
}

void draw() {
}


void readXML() {
  // Boucle de traitement des données XML
  for (int i = 0; i < numCitys; i++) {
    // Selection des données du tableau XML pour chaque entrée
    XML[] idXml = cityXml[i].getChildren("cityId");
    int id = int(idXml[0].getContent());
    XML[] cityLatXml = cityXml[i].getChildren("lat");
    float cityLat = float(cityLatXml[0].getContent());
    XML[] cityLonXml = cityXml[i].getChildren("lon");
    float cityLon = float(cityLonXml[0].getContent());
    XML[] cityConXml = cityXml[i].getChildren("connectNum");
    int cityCon = int(cityConXml[0].getContent());
    XML[] cityNamXml = cityXml[i].getChildren("city");
    String cityNam = cityNamXml[0].getContent();
    
    // Condition d'affichage de l'entrée du tableau suivant le nombre de connexion
    if(cityCon > 0) // && cityCon < 100
    {
      // Renvoie des données traitées
      println(id + ", " + cityLat + ", " + cityLon + ", " + cityCon + ", " + cityNam);
      
      // Affichage de l'entrée du tableau par ellipse
      noStroke();
      fill(100, 100, 100, 150);
      ellipse(cityLon*zoomFact + merid, equat - cityLat*zoomFact, cityCon, cityCon);
    }
  }
}