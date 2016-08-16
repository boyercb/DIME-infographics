import processing.pdf.*;

//global vars
JSONArray json;

PShape icn;
PShape star;
PShape person;
PShape check;

PFont boldFont;
PFont lightFont;

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
  json = loadJSONArray("poster2_data.json");
  
  //for(int j = 10; j < 20; j = j+1){
  for(int j = 0; j < json.size(); j = j+1){

    JSONObject communeData = json.getJSONObject(j);
    JSONArray sections = communeData.getJSONArray("items");
    beginRecord(PDF, "pdf/" + communeData.getString("commune") + ".pdf");
    //size(w, h);
    background(255);
    fill(0);
  
    boldFont = createFont("GillSans-Bold",93);
    lightFont = createFont("GillSans-Light",50);
    
    textFont(boldFont);
    
    //SECTION: Title
  
    fill(primaryColor);
    text(communeData.getString("label"), 77, 100);
    
    fill(textColor);
    textFont(lightFont);
    text("SERVICES PUBLICS", 77, 200);
    //text("CAPACITÉ INSTITUTIONELLE", 77, 200);
    textAlign(RIGHT);
    text("MUNICIPALITÉ DE " + communeData.getString("commune"), 1883, 200);
    textAlign(LEFT);
    
    float middleX = (w - textWidth("MUNICIPALITÉ DE " + communeData.getString("commune")) - textWidth("CAPACITÉ INSTITUTIONELLE") - 400) * 0.5;
    
    //three dots FIXME
    noStroke();
    fill(highlightColor);
    for (int i = 0; i < 3; i = i+1) {
      ellipse(middleX + textWidth("COMPÉTENCE MUNICIPALE") + 200 + (i * 30) - ((3*30)/2) + 20, 180, 22, 22);
    }
    
    sectionHeader(249, "ecoles.svg", sections.getJSONObject(0).getString("label"),sections.getJSONObject(0).getFloat("points"),sections.getJSONObject(0).getFloat("max_points"));
    sectionHeader(1156, "sante.svg", sections.getJSONObject(1).getString("label"),sections.getJSONObject(1).getFloat("points"),sections.getJSONObject(1).getFloat("max_points"));
    sectionHeader(1942, "water.svg", sections.getJSONObject(2).getString("label"),sections.getJSONObject(2).getFloat("points"),sections.getJSONObject(2).getFloat("max_points"));
    sectionHeader(2306, "birth.svg", sections.getJSONObject(3).getString("label"),sections.getJSONObject(3).getFloat("points"),sections.getJSONObject(3).getFloat("max_points"));
    
    //ÉCOLES PRIMAIRES
    
    //Taux d'Admission du CEP comparé à la moyenne nationale
    JSONObject jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,432, "%");
    
    //% d'écoles recevant les fournitures scolaires avant le début de l'année scolaire 2013/2014
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(1);
    scaleBackward(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,614, "%");
    
    //% d'écoles avec un forage fonctionnel
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,854, "%");
    
     
    //d’écoles avec des latrines fonctionnelles pour chaque classe
    jo = sections.getJSONObject(0).getJSONArray("items").getJSONObject(3);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1020, "%");
      
    //SANTÉ
      
    //d’accouchements assistés pendant l’année
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1342, "%");
      
    //de nourrissons 0-11 mois ayant été vaccinés avec le BCG, VAR, VAA, VPO3, DTC-Hep+Hib3 en 2013
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(1);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1570, "%");
      
    //de CSPS ayant reçu un stock de Gaz de la municipalité entre juin et décembre 2013*
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1794, "%");
     
    //EAU ET ASSAINISSEMENT
    
    //de la population avec accès à une source d’eau potable fonctionnelle à 1000m pour 300 personnes/ forage.*
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,2124, "%");
      
    //ACTES DE NAISSANCES
    
    //Nombre d’actes de naissances délivrés comparé aux naissances attendues
    jo = sections.getJSONObject(3).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,2474, "%");
    
    total(communeData.getString("year"), communeData.getFloat("total_points"), communeData.getFloat("max_points"), communeData.getInt("stars"));
  
    endRecord();
  }
  
  

}

//Section header template
void sectionHeader(int yPos, String iconPath, String title, float points, float max){
  
  icn = loadShape(iconPath);
  
  fill(secondaryColor);
  noStroke();
  rect(65,yPos, 1590, 96);
  
  stroke(primaryColor);
  fill(255);
  strokeWeight(9);
  
  line(65,yPos,1638,yPos);
  
  ellipse(136,97 + yPos,246,246);
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
  textSize(48);
  float tw = textWidth(title);
  text(title, 290, yPos + 65);
  
  textFont(lightFont);
  textSize(42);
  text("— " + points + "/" + max + " points", tw + 310, yPos + 60);
  
  //FIXME: Figure out the correct star mapping
  stars(int((points/max)/(.2)), yPos);
  
}

//Stars for section ratings
void stars(int rating, int yPos){
  fill(0);
  //space between stars
  int gap = 60; 
  star = loadShape("star.svg");
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
  
  
  rect(xPos + scaleX - 6,scaleY - 30,12,scaleHeight + 50);
  ellipse(xPos + scaleX,scaleY - 30,63,63);
  ellipse(xPos + scaleX,scaleY + 80,63,63);
  
  fill(255);
  textAlign(CENTER);

  
  textFont(boldFont);
  textSize(32);
  if(round(score) - score == 0){
    text(round(score),xPos + scaleX,scaleY - 20);
  }
  else{
    text(String.format("%.1f", score),xPos + scaleX,scaleY - 20);
  }
  
  
  textFont(lightFont);
  textSize(32);
  text(round(value),xPos + scaleX,scaleY + scaleHeight + 40);
  
  fill(0);
  
  //top labels (points)
  textFont(boldFont);
  textSize(32);
  for (int i = 0; i < points.length; i = i+1) {
    //blank out label if close to score
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 20);
    }
  }
  text("pts.", scaleWidth + scaleX + 75, scaleY - 20);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(32);
  for (int i = 0; i < scaleMarks.length; i = i+1) {
    
    //blank out label if close to value
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
       text(scaleMarks[i], map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY + scaleHeight + 40);
    }
  }
  textAlign(LEFT);
  text(scaleUnit, scaleWidth + scaleX + 30, scaleY + scaleHeight + 40);
   
  
  // label
  textAlign(RIGHT);
  textFont(boldFont);
  textSize(35);
  
  float textHeight = split(label, "\n").length * (textAscent() + textDescent());
  
  text(label, scaleX - 200, scaleY - (textHeight * 0.5) + 50);
  
  
}





//sS
void scale(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  
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
  triangle(scaleX,scaleY - 2,scaleWidth + scaleX,scaleY - 2,scaleX,(scaleHeight * 0.5) + scaleY);
  triangle(scaleX,(scaleHeight/2) + scaleY,scaleWidth + scaleX,scaleHeight + scaleY + 2,scaleX,scaleHeight + scaleY + 2);
  
  //marker
  fill(highlightColor);
  stroke(255);
  strokeWeight(3);
  ellipseMode(CENTER);
  
  if(value > max){
    value = max;
  }
  
  rect(xPos + scaleX - 6,scaleY - 30,12,scaleHeight + 50);
  ellipse(xPos + scaleX,scaleY - 30,63,63);
  ellipse(xPos + scaleX,scaleY + 80,63,63);
  
  fill(255);
  textAlign(CENTER);

  
  textFont(boldFont);
  textSize(32);
  if(round(score) - score == 0){
    text(round(score),xPos + scaleX,scaleY - 20);
  }
  else{
    text(String.format("%.1f", score),xPos + scaleX,scaleY - 20);
  }
  
  
  textFont(lightFont);
  textSize(32);
  text(round(value),xPos + scaleX,scaleY + scaleHeight + 40);
  
  fill(0);
  
  //top labels (points)
  textFont(boldFont);
  textSize(32);
  for (int i = 0; i < points.length; i = i+1) {
    //blank out label if close to score
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 20);
    }
  }
  text("pts.", scaleWidth + scaleX + 75, scaleY - 20);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(32);
  for (int i = 0; i < scaleMarks.length; i = i+1) {
    
    //blank out label if close to value
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
       text(scaleMarks[i], map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY + scaleHeight + 40);
    }
  }
  textAlign(LEFT);
  text(scaleUnit, scaleWidth + scaleX + 30, scaleY + scaleHeight + 40);
   
  
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
  line(0, 2656, w, 2656);
  
  textFont(lightFont);
  textSize(96);
  textAlign(LEFT);
  fill(primaryColor);
  text("Points total en " + year + ":", 61, 2772);
  float tw = textWidth("Points total en " + year + ":");
  
  textFont(boldFont);
  text(totalPoints + "/" + maxPoints, 85 + tw, 2772);
  
  fill(0);
  //space between stars
  int gap = 70; 
  star = loadShape("star.svg");
  star.disableStyle();
  star.scale(1);
  noStroke();
  
  println(stars);
  
  for (int i = 0; i < 5; i = i+1) {
    
    if(i < stars){
      fill(highlightColor);
    }
    else{
      fill(225);
    }
    shape(star, gap * i + 1550, 2656 + 40);
    
  }
  
}