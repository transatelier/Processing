XML xml;
XML[] cityXml;
int numCitys;
int merid;
int equat;
float zoomFact;

void setup() {
  size(1280, 960);
  background(255, 255, 255);
  
  merid = width/2;
  equat = height/2;
  zoomFact = 3;
  
  // refresh ip dataBase  http://www.cabsii.net/netart/dataIp/recupIpBase.php
  xml = loadXML("ipXmlFile.xml");
  cityXml = xml.getChildren("ipbases");
  numCitys = cityXml.length;
  
  //Afficher map monde
  /*
  PImage map;
  map = loadImage("planisphere.png");
  int mapW = 1210;
  int mapH = 525;
  map.resize(mapW, mapH);
  float mapX = merid - mapW/2.08;
  float mapY = equat- mapH/1.58;
  image(map,mapX,mapY);*/
  
  
  readXML();
}

void draw() {
}


void readXML() {
  for (int i = 0; i < numCitys; i++) {
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
    
    if(cityCon > 0) // && cityCon < 100
    {
      println(id + ", " + cityLat + ", " + cityLon + ", " + cityCon + ", " + cityNam);
      
      noStroke();
      fill(100, 100, 100, 150);
      ellipse(cityLon*zoomFact + merid, equat - cityLat*zoomFact, cityCon, cityCon);
    }
  }
}