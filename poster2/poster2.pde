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

PImage logo;

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
  json = loadJSONArray("../data/json/2015/poster2.json");
  
  //for(int j = 10; j < 20; j = j+1){
  for(int j = 0; j < json.size(); j = j+1){

    JSONObject communeData = json.getJSONObject(j);
    JSONArray sections = communeData.getJSONArray("items");
    beginRecord(PDF, "pdf/2015/" + communeData.getString("commune") + ".pdf");
    //size(w, h);
    background(255);
    fill(0);
  
    boldFont = createFont("Lato Bold", 83);
    lightFont = createFont("Lato-Light", 40);
    
    img111 = loadImage("jpg/CEP_left_resized.png");
    img112 = loadImage("jpg/CEP_right_resized.png");
    img121 = loadImage("jpg/eleves qui li en classe_left_resized.png");
    img122 = loadImage("jpg/eleves qui li en classe_right_resized.png"); 
    img131 = loadImage("jpg/ecole avec forage_left_resized.png");
    img132 = loadImage("jpg/ecole avec forage_right_resized.png");
    img141 = loadImage("jpg/ecole sans latrine_left_resized.png");
    img142 = loadImage("jpg/ecole avec latrine_right_resized.png");
    img211 = loadImage("jpg/accouchement nom assistee_left_resized.png");
    img212 = loadImage("jpg/accouchement assistee_right_resized.png");
    img221 = loadImage("jpg/vaccin de 0-11_left_resized.png"); 
    img222 = loadImage("jpg/vaccin de 0-11_right_resized.png"); 
    img231 = loadImage("jpg/csps sans stock de gaz_left_resized.png"); 
    img232 = loadImage("jpg/csps recu un stock de gaz_right_resized.png"); 
    img311 = loadImage("jpg/village sans forage_left_resized.png"); 
    img312 = loadImage("jpg/village avec forage_right_resized.png"); 
    img411 = loadImage("jpg/maireie acte de naissances abscent_left_resized.png"); 
    img412 = loadImage("jpg/maireie acte de naissances present_right_resized.png"); 

    logo = loadImage("svg/logo.jpg");

    textFont(boldFont);
    
    //SECTION: Title
  
    String commune = communeData.getString("commune");
    fill(primaryColor);
    text("MUNICIPALITÉ DE " + commune.replaceAll("_", " "), (w - textWidth("MUNICIPALITÉ DE " + commune)) / 2, 90);
    
    fill(textColor);
    textFont(lightFont);
    text(communeData.getString("label"), 77, 140);
    textAlign(RIGHT);
    text("SERVICES PUBLICS", w - 77 - textWidth(communeData.getString("label"))/2 + textWidth("SERVICES PUBLIC")/2, 140);
    textAlign(LEFT);
    
    float middleX = (w - 102) * 0.5;
    
    //three dots FIXME
/*  noStroke();
    fill(highlightColor);
    for (int i = 0; i < 3; i = i+1) {
      ellipse(middleX + textWidth(communeData.getString("label")) + 200 + (i * 30) - ((3*30)/2) + 20, 150, 22, 22);
    } */
    //+ textWidth(communeData.getString("label")) + 200 - 125/2
    image(logo, middleX , 108, 102, 70);

    image(img111, 350, 285, 373, 220);    // original (868, 613)
    image(img112, 1535, 285, 373, 220);    // original (868, 613)
    image(img121, 350, 520, 373, 220);   // original (868, 613)
    image(img122, 1535, 520, 373, 220);   // original (869, 613)    
    image(img131, 350, 755, 373, 220);    //
    image(img132, 1535, 755, 373, 220); 
    image(img141, 350, 990, 373, 220);
    image(img142, 1535, 990, 373, 220);   
   
    // section 2
    image(img211, 350, 1320, 373, 220);
    image(img212, 1535, 1320, 373, 220);    
    image(img221, 350, 1555, 373, 220);
    image(img222, 1535, 1555, 373, 220);      
    image(img231, 350, 1785, 373, 220);
    image(img232, 1535, 1785, 373, 220);  

    // section 3
    image(img311, 350, 2130, 373, 220);
    image(img312, 1535, 2130, 373, 220);
     
    // section 4
    image(img411, 350, 2466, 373, 220);
    image(img412, 1535, 2466, 373, 220);
    
    sectionHeader(185, 
                  "svg/ecoles.svg", 
                  sections.getJSONObject(0).getString("label"),
                  sections.getJSONObject(0).getFloat("points"),
                  sections.getJSONObject(0).getFloat("max_points"),
                  sections.getJSONObject(0).getInt("stars"));
    sectionHeader(1230, 
                  "svg/sante.svg", 
                  sections.getJSONObject(1).getString("label"),
                  sections.getJSONObject(1).getFloat("points"),
                  sections.getJSONObject(1).getFloat("max_points"),
                  sections.getJSONObject(1).getInt("stars"));
    sectionHeader(2026, 
                  "svg/water.svg", 
                  sections.getJSONObject(2).getString("label"),
                  sections.getJSONObject(2).getFloat("points"),
                  sections.getJSONObject(2).getFloat("max_points"),
                  sections.getJSONObject(2).getInt("stars"));
    sectionHeader(2366,
                  "svg/birth.svg", 
                  sections.getJSONObject(3).getString("label"),
                  sections.getJSONObject(3).getFloat("points"),
                  sections.getJSONObject(3).getFloat("max_points"),
                  sections.getJSONObject(3).getInt("stars"));
    
    //ÉCOLES PRIMAIRES
    
    //Taux d'Admission du CEP comparé à la moyenne nationale
    JSONObject jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 375, "pts de %");

    //% d'écoles recevant les fournitures scolaires avant le début de l'année scolaire 2013/2014
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(1);
    scaleBackward(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 610, "jours");
    
    //% d'écoles avec un forage fonctionnel
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 855, "%");
    
    //d’écoles avec des latrines fonctionnelles pour chaque classe
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(3);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 1080, "%");
    
    //SANTÉ
      
    //d’accouchements assistés pendant l’année
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 1410, "%");
      
    //de nourrissons 0-11 mois ayant été vaccinés avec le BCG, VAR, VAA, VPO3, DTC-Hep+Hib3 en 2013
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(1);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 1645, "%");
      
    //de CSPS ayant reçu un stock de Gaz de la municipalité entre juin et décembre 2013*
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 1875, "%");
    
    //EAU ET ASSAINISSEMENT
    
    //de la population avec accès à une source d’eau potable fonctionnelle à 1000m pour 300 personnes/ forage.*
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 2220, "%");
    
    //ACTES DE NAISSANCES
    
    //Nombre d’actes de naissances délivrés comparé aux naissances attendues
    jo = sections.getJSONObject(3).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      825, 2556, "%");
    
    total(communeData.getString("year"), communeData.getFloat("total_points"), communeData.getFloat("max_points"), communeData.getInt("stars"));
  
    endRecord();
  }
  
  

}

//Section header template
void sectionHeader(int yPos, String iconPath, String title, float points, float max, int numstars){
  
  icn = loadShape(iconPath);
  
  fill(secondaryColor);
  noStroke();
  rect(65, yPos, 1590, 76);
  
  stroke(primaryColor);
  fill(255);
  strokeWeight(9);
  
  line(65, yPos, 1638, yPos);
  
  // original ellipse (246, 246)
  if (iconPath == "svg/sante.svg") {
      ellipse(136, 67 + yPos, 200, 200);
      shape(icn, 51,yPos - 5, 180, 180);
  } else if (iconPath == "svg/birth.svg") {
      ellipse(136, 67 + yPos, 200, 200);
      shape(icn, 46,yPos, 180, 180);    
  } else {
      ellipse(136, 67 + yPos, 200, 200);
      shape(icn, 46,yPos - 20, 180, 180);    
  }
  
  fill(255);
  noStroke();
  beginShape();
  vertex(1647,yPos - 10);
  vertex(1710,yPos - 10);
  vertex(1660,yPos + 80);
  vertex(1597,yPos + 80);
  endShape();
  
  textFont(boldFont);
  textSize(44);
  float tw = textWidth(title);
  text(title, 290, yPos + 55);
  
  textFont(lightFont);
  textSize(40);
  text("— " + points + "/" + max + " points", tw + 300, yPos + 52);
  
  //FIXME: Figure out the correct star mapping
  stars(numstars, yPos);
  
}

//Stars for section ratings
void stars(float rating, int yPos){
  fill(0);
  //space between stars
  int gap = 60; 
  star = loadShape("svg/star.svg");
  star.disableStyle();
  star.scale(0.8);
  strokeWeight(1);
  stroke(primaryColor);
  
  for (int i = 0; i < 5; i = i+1) {
     fill(primaryColor, 30);
     shape(star, gap * i + 1640, yPos + 15);
  }

  for (int i = 0; i < floor(rating); i = i+1) {
     fill(primaryColor);
     shape(star, gap * i + 1640, yPos + 15);
  }

     //shape(star, gap * (floor(rating) + 1) + 1640, yPos + 15);

}

//Tara - edit
void scaleBackward(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  println("value: " + value);
  int scaleHeight = 50;
  int scaleWidth = 600;
  
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
    if(abs(value - scaleMarks[i]) > .1 * (min - max) && xPos + map(scaleMarks[i], max, min, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 15);
    }
  }
  text("pts.", scaleWidth + scaleX + 50, scaleY - 15);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(22);
  for (int i = 0; i < scaleMarks.length; i = i+1) {
    
    //blank out label if close to value
    if(abs(value - scaleMarks[i]) > .1 * (min - max) && xPos + map(scaleMarks[i], max, min, 0, scaleWidth) != 0){
       text(scaleMarks[i], map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY + scaleHeight + 30);
    }
  }
  textAlign(LEFT);
  text(scaleUnit, scaleWidth + scaleX + 30, scaleY + scaleHeight + 30);
   
  
  // label
  textAlign(RIGHT);
  textFont(boldFont);
  textSize(22);
  
  float textHeight = split(label, "\n").length * (textAscent() + textDescent());
  
  text(label, scaleX - 373 - 150, scaleY - (textHeight * 0.5) + 50);
  
  
}





//SCALES
void scale(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  
  int scaleHeight = 50;
  int scaleWidth = 600;
  
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
  
  fill(255);
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
  textSize(22);
  
  float textHeight = split(label, "\n").length * (textAscent() + textDescent());
  
  text(label, scaleX - 373 - 150, scaleY - (textHeight * 0.5) + 50);
  
  
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
    
    if(i < stars + 0.1){
      fill(highlightColor);
    }
    else{
      fill(225);
    }
    shape(star, gap * i + 1550, 2661 + 58);
    
  }
  
}