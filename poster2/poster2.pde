import processing.pdf.*;

//global vars
JSONArray json;

PShape icn;
PShape star;
PShape person;
PShape check;

PFont boldFont;
PFont lightFont;

PImage img111;
PImage img112;
PImage img121;
PImage img122;
PImage img131;
PImage img132;
PImage img141;
PImage img142;
PImage img211;
PImage img212;
PImage img221;
PImage img222;
PImage img231;
PImage img232;
PImage img311;
PImage img312;
PImage img411;
PImage img412;

Table data;

//colors
int primaryColor = color(214,88,59);
int secondaryColor = color(220,119,89);
int highlightColor = color(67,138,201);
int textColor = color(0);

//poster dimensions
int w = 1955;
int h = 2806;

void settings() {
  size(w, h);
}

void setup(){
  
  //LOAD DATA FILE
  json = loadJSONArray("../data/json/poster2.json");
  
  //for(int j = 10; j < 20; j = j+1){
  for(int j = 0; j < json.size(); j = j+1){

    JSONObject communeData = json.getJSONObject(j);
    JSONArray sections = communeData.getJSONArray("items");
    beginRecord(PDF, "pdf/" + communeData.getString("commune") + ".pdf");
    //size(w, h);
    background(255);
    fill(0);
  
    boldFont = createFont("Lato Bold", 83);
    lightFont = createFont("Lato-Light", 40);
    
    img111 = loadImage("jpg/CEP 001_resized.png");
    img112 = loadImage("jpg/CEP 002_resized.png");
    img121 = loadImage("jpg/eleves qui li en classe 02_resized.png");
    img122 = loadImage("jpg/eleves qui li en classe 01 copie_resized.png"); 
    img131 = loadImage("jpg/ecole avec forage 001_resized.png");
    img132 = loadImage("jpg/ecole avec forage 0002_resized.png");
    img141 = loadImage("jpg/ecole avec latrine_resized.png");
    img142 = loadImage("jpg/ecole sans latrine_resized.png");
    img211 = loadImage("jpg/accouchement assistee 002_resized.png");
    img212 = loadImage("jpg/accouchement nom assistee 01_resized.png");
    img221 = loadImage("jpg/vaccin de 0-11-00002 copie_resized.png"); 
    img222 = loadImage("jpg/vaccin de 0-11-00001 copie_resized.png"); 
    img231 = loadImage("jpg/csps recu un stock de gaz 01_resized.png"); 
    img232 = loadImage("jpg/csps sans stock de gaz 02_resized.png"); 
    img311 = loadImage("jpg/village avec forage 01_resized.png"); 
    img312 = loadImage("jpg/village sans forage_resized.png"); 
    img411 = loadImage("jpg/maireie acte de naissances present_resized.png"); 
    img412 = loadImage("jpg/maireie acte de naissances abscent_resized.png"); 

    textFont(boldFont);
    
    //SECTION: Title
  
    fill(primaryColor);
    text(communeData.getString("label"), 77, 90);
    
    fill(textColor);
    textFont(lightFont);
    text("SERVICES PUBLICS", 77, 140);
    //text("CAPACITÉ INSTITUTIONELLE", 77, 200);
    textAlign(RIGHT);
    text("MUNICIPALITÉ DE " + communeData.getString("commune"), 1883, 140);
    textAlign(LEFT);
    
    float middleX = (w - textWidth("MUNICIPALITÉ DE " + communeData.getString("commune")) - textWidth("CAPACITÉ INSTITUTIONELLE") - 400) * 0.5;
    
    //three dots FIXME
    noStroke();
    fill(highlightColor);
    for (int i = 0; i < 3; i = i+1) {
      ellipse(middleX + textWidth("COMPÉTENCE MUNICIPALE") + 200 + (i * 30) - ((3*30)/2) + 20, 130, 22, 22);
    }

    image(img111, 100, 300, 394, 248);    // original (868, 613)
    image(img112, 528, 300, 394, 248);    // original (868, 613)
    image(img121, 1020, 300, 394, 248);   // original (868, 613)
    image(img122, 1448, 300, 394, 248);   // original (869, 613)    
    image(img131, 100, 730, 394, 248);    //
    image(img132, 528, 730, 394, 248); 
    image(img141, 1020, 730, 394, 248);
    image(img142, 1448, 730, 394, 248);   
   
    // section 2
    image(img211, 100, 1251, 394, 248);
    image(img212, 528, 1251, 394, 248);    
    image(img221, 1020, 1251, 394, 248);
    image(img222, 1448, 1251, 394, 248);      
    image(img231, 287, 1685, 394, 248);
    image(img232, 715, 1685, 394, 248);  

    // section 3
    image(img311, 287, 2066, 394, 248);
    image(img312, 715, 2066, 394, 248);
     
    // section 4
    image(img411, 287, 2446, 394, 248);
    image(img412, 715, 2446, 394, 248);
    
    sectionHeader(180, "svg/ecoles.svg", sections.getJSONObject(0).getString("label"),sections.getJSONObject(0).getFloat("points"),sections.getJSONObject(0).getFloat("max_points"));
    sectionHeader(1131, "svg/sante.svg", sections.getJSONObject(1).getString("label"),sections.getJSONObject(1).getFloat("points"),sections.getJSONObject(1).getFloat("max_points"));
    sectionHeader(1946, "svg/water.svg", sections.getJSONObject(2).getString("label"),sections.getJSONObject(2).getFloat("points"),sections.getJSONObject(2).getFloat("max_points"));
    sectionHeader(2326, "svg/birth.svg", sections.getJSONObject(3).getString("label"),sections.getJSONObject(3).getFloat("points"),sections.getJSONObject(3).getFloat("max_points"));
    
    //ÉCOLES PRIMAIRES
    
    //Taux d'Admission du CEP comparé à la moyenne nationale
    JSONObject jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      225, 595, "%");

    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 280, 285);
    
    //% d'écoles recevant les fournitures scolaires avant le début de l'année scolaire 2013/2014
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(1);
    scaleBackward("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1150, 595, "%");

    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 1050, 285);
    
    //% d'écoles avec un forage fonctionnel
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(2);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      225, 1027, "%");
    
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 300, 710);
    
    //d’écoles avec des latrines fonctionnelles pour chaque classe
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(3);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1150, 1027, "%");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 1100, 710);
    
    //SANTÉ
      
    //d’accouchements assistés pendant l’année
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      225, 1548, "%");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 280, 1235);
    
      
    //de nourrissons 0-11 mois ayant été vaccinés avec le BCG, VAR, VAA, VPO3, DTC-Hep+Hib3 en 2013
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(1);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1150, 1548, "%");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 1150, 1235);
      
    //de CSPS ayant reçu un stock de Gaz de la municipalité entre juin et décembre 2013*
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(2);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1200, 1778, "%");
     
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 280, 1664);
    
    //EAU ET ASSAINISSEMENT
    
    //de la population avec accès à une source d’eau potable fonctionnelle à 1000m pour 300 personnes/ forage.*
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1200, 2170, "%");
     
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 280, 2049);
    
    //ACTES DE NAISSANCES
    
    //Nombre d’actes de naissances délivrés comparé aux naissances attendues
    jo = sections.getJSONObject(3).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1200, 2550, "%");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(22);
    text(jo.getString("label"), 280, 2430);
    
    total(communeData.getString("year"), communeData.getFloat("total_points"), communeData.getFloat("max_points"), communeData.getInt("stars"));
  
    endRecord();
  }
  
  

}

//Section header template
void sectionHeader(int yPos, String iconPath, String title, float points, float max){
  
  icn = loadShape(iconPath);
  
  fill(secondaryColor);
  noStroke();
  rect(65, yPos, 1590, 76);
  
  stroke(primaryColor);
  fill(255);
  strokeWeight(9);
  
  line(65, yPos, 1638, yPos);
  
  ellipse(136, 97 + yPos, 246, 246);
  shape(icn, 26, 10 + yPos);
  
  fill(255);
  noStroke();
  beginShape();
  vertex(1647,yPos - 10);
  vertex(1710,yPos - 10);
  vertex(1660,yPos + 100);
  vertex(1597,yPos + 100);
  endShape();
  
  textFont(boldFont);
  textSize(44);
  float tw = textWidth(title);
  text(title, 290, yPos + 55);
  
  textFont(lightFont);
  textSize(40);
  text("— " + points + "/" + max + " points", tw + 300, yPos + 52);
  
  //FIXME: Figure out the correct star mapping
  stars(int((points/max)/(.2)), yPos);
  
}

//Stars for section ratings
void stars(int rating, int yPos){
  fill(0);
  //space between stars
  int gap = 60; 
  star = loadShape("svg/star.svg");
  star.disableStyle();
  star.scale(0.8);
  strokeWeight(1);
  stroke(primaryColor);
  
  for (int i = 0; i < 5; i = i+1) {
    
    if(i < rating){
      fill(primaryColor);
    }
    else{
      fill(primaryColor, 30);
    }
    shape(star, gap * i + 1640, yPos + 15);
    
  }
}

//Tara - edit
void scaleBackward(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  println("value: " + value);
  int scaleHeight = 50;
  int scaleWidth = 700;
  
  int startColor = color(235,180,158);
  int endColor = primaryColor;
  
  int gap = 3;
  
  int min = scaleMarks[0];
  int max = scaleMarks[scaleMarks.length - 1];
  
  float xPos = map(value, min, max, 0, scaleWidth);
  if(xPos < 0){
   xPos = 0; 
  }
  if(xPos > scaleWidth){
   xPos = scaleWidth; 
  }
  
  //scale divisions
  for (int i = 0; i < points.length; i = i+1) {
    fill(lerpColor(startColor,endColor, i / float(points.length)));
    if(i < points.length - 1){
      rect(map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX,scaleY,(map(scaleMarks[i + 1], min, max, 0, scaleWidth) - map(scaleMarks[i], min, max, 0, scaleWidth)),scaleHeight);
    }
  }
  
  //gap lines
  for (int i = 0; i < points.length; i = i+1) {
    stroke(255);
    strokeWeight(gap);
    line(map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX,scaleY,map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX,scaleY + scaleHeight);
  }
  
  //triangle mask
  fill(255);
  triangle(scaleWidth + scaleX,scaleY-2, scaleX,scaleY-2,scaleWidth + scaleX,(scaleHeight * 0.5) + scaleY);
  triangle(scaleWidth + scaleX,(scaleHeight/2) + scaleY,scaleX,scaleHeight + scaleY+2, scaleWidth + scaleX,scaleHeight + scaleY+2);
  //triangle(scaleX,scaleY - 2,scaleWidth + scaleX,scaleY - 2,scaleX,(scaleHeight * 0.5) + scaleY);
  //triangle(scaleX,(scaleHeight/2) + scaleY,scaleWidth + scaleX,scaleHeight + scaleY + 2,scaleX,scaleHeight + scaleY + 2);
  
  
  //marker
  fill(highlightColor);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);
  
  //min = 30
  //max = 0
  
  if(value > min){
    value = min;
  }
  if (value < max){
    value = max;
  }
  
  rect(xPos + scaleX - 6, scaleY - 22, 12, scaleHeight + 40);
  ellipse(xPos + scaleX, scaleY - 22, 45, 45);
  ellipse(xPos + scaleX, scaleY + 72, 45, 45);
  
  
  fill(255);
  textAlign(CENTER);

  
  textFont(boldFont);
  textSize(22);
  if(round(score) - score == 0){
    text(round(score),xPos + scaleX,scaleY - 15);
  }
  else{
    text(String.format("%.1f", score),xPos + scaleX,scaleY - 15);
  }
  
  
  textFont(lightFont);
  textSize(22);
  text(round(value),xPos + scaleX,scaleY + scaleHeight + 30);
  
  fill(0);
  
  //top labels (points)
  textFont(boldFont);
  textSize(22);
  for (int i = 0; i < points.length; i = i+1) {
    //blank out label if close to score
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 15);
    }
  }
  text("pts.", scaleWidth + scaleX + 75, scaleY - 15);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(22);
  for (int i = 0; i < scaleMarks.length; i = i+1) {
    
    //blank out label if close to value
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
       text(scaleMarks[i], map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY + scaleHeight + 30);
    }
  }
  textAlign(LEFT);
  text(scaleUnit, scaleWidth + scaleX + 30, scaleY + scaleHeight + 30);
   
  
  // label
  textAlign(RIGHT);
  textFont(boldFont);
  textSize(35);
  
  float textHeight = split(label, "\n").length * (textAscent() + textDescent());
  
  text(label, scaleX - 200, scaleY - (textHeight * 0.5) + 50);
  
  
}





//SCALES
void scale(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  
  int scaleHeight = 50;
  int scaleWidth = 600;
  
  int startColor = color(217,239,235);
  int endColor = color(110,200,192);
  
  int gap = 3;
  
  int min = scaleMarks[0];
  int max = scaleMarks[scaleMarks.length - 1];
  
  float xPos = map(value, min, max, 0, scaleWidth);
  if(xPos < 0){
   xPos = 0; 
  }
  if(xPos > scaleWidth){
   xPos = scaleWidth; 
  }
  
  //scale divisions
  for (int i = 0; i < points.length; i = i+1) {
    fill(lerpColor(startColor,endColor, i / float(points.length)));
    if(i < points.length - 1){
      rect(map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY,(map(scaleMarks[i + 1], min, max, 0, scaleWidth) - map(scaleMarks[i], min, max, 0, scaleWidth)),scaleHeight);
    }
  }
  
  //gap lines
  for (int i = 0; i < points.length; i = i+1) {
    stroke(255);
    strokeWeight(gap);
    line(map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX,scaleY,map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX,scaleY + scaleHeight);
  }
  
  //triangle mask
  fill(255);
  triangle(scaleX, scaleY - 2,scaleWidth + scaleX, scaleY - 2,scaleX, (scaleHeight * 0.5) + scaleY);
  triangle(scaleX, (scaleHeight/2) + scaleY, scaleWidth + scaleX, scaleHeight + scaleY + 2,scaleX,scaleHeight + scaleY + 2);
  
  //marker
  fill(highlightColor);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);
  
  if(value > max){
    value = max;
  }
  println("label" + label);
  println("x" + xPos);
  
  rect(xPos + scaleX - 6, scaleY - 22, 12, scaleHeight + 40);
  ellipse(xPos + scaleX, scaleY - 22, 45, 45);
  ellipse(xPos + scaleX, scaleY + 72, 45, 45);
  
  fill(0);
  textAlign(CENTER);

  
  textFont(boldFont);
  textSize(22);
  if(round(score) - score == 0){
    text(round(score), xPos + scaleX, scaleY - 15);
  }
  else{
    text(String.format("%.1f", score), xPos + scaleX, scaleY - 15);
  }
  
  
  textFont(lightFont);
  textSize(22);
  text(round(value), xPos + scaleX, scaleY + scaleHeight + 30);
  
  //top labels (points)
  textFont(boldFont);
  textSize(22);
  for (int i = 0; i < points.length; i = i+1) {
    //blank out label if close to score
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 15);
    }
  }
  text("pts.", scaleWidth + scaleX + 50, scaleY - 15);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(22);
  for (int i = 0; i < scaleMarks.length; i = i+1) {
    
    //blank out label if close to value
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
       text(scaleMarks[i], map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY + scaleHeight + 30);
    }
  }
  textAlign(LEFT);
  text(scaleUnit, scaleWidth + scaleX + 30, scaleY + scaleHeight + 30);
    
  // label
  textAlign(RIGHT);
  textFont(boldFont);
  textSize(35);
  
  float textHeight = split(label, "\n").length * (textAscent() + textDescent());
  
  text(label, scaleX - 200, scaleY - (textHeight * 0.5) + 50);
  
  
}

void total(String year, float totalPoints, float maxPoints, int stars){
  
  stroke(primaryColor);
  strokeWeight(9);
  line(0, 2706, w, 2706);
  
  textFont(lightFont);
  textSize(83);
  textAlign(LEFT);
  fill(primaryColor);
  text("Points total en " + year + ":", 61, 2790);
  float tw = textWidth("Points total en " + year + ":");
  
  textFont(boldFont);
  text(totalPoints + "/" + maxPoints, 85 + tw, 2790);
  
  fill(0);
  //space between stars
  int gap = 70; 
  star = loadShape("svg/star.svg");
  star.disableStyle();
  star.scale(1);
  noStroke();
  
  for (int i = 0; i < 5; i = i+1) {
    
    if(i < stars){
      fill(highlightColor);
    }
    else{
      fill(225);
    }
    shape(star, gap * i + 1550, 2661 + 58);
    
  }
  
}