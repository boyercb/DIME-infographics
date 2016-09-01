import processing.pdf.*;

//global vars
JSONArray json;

PShape icn;
PShape star;
PShape person;
PShape check;

PFont boldFont;
PFont lightFont;

PImage img1;
PImage img2;
PImage img3;
PImage img3b;
PImage img4;
PImage img5;
PImage img6;
PImage img7;
PImage img8;
PImage img9;
PImage img10;

Table data;

//colors
int primaryColor = color(94,174,164);
int secondaryColor = color(111,200,192);
int highlightColor = color(254,201,94);
int textColor = color(0);

//poster dimensions
int w = 1955;
int h = 2806;

void settings() {
  size(w, h);
}

void setup(){
  
  //LOAD DATA FILE
  json = loadJSONArray("../data/json/poster1.json");
  
  //for(int j = 10; j < 20; j = j+1){
  for(int j = 0; j < json.size(); j = j+1){

    JSONObject communeData = json.getJSONObject(j);
    JSONArray sections = communeData.getJSONArray("items");
    beginRecord(PDF, "pdf/" + communeData.getString("commune") + ".pdf");
    //size(w, h);
    background(255);
    fill(0);
  
    boldFont = createFont("Lato Bold", 93);
    lightFont = createFont("Lato-Light", 50);
    
    img1 = loadImage("jpg/personel dans la municipalite 01 ecrito copie_resized.png");
    img2 = loadImage("jpg/nombre de session ordinaire_resized.png");
    img3 = loadImage("jpg/taux de participation au reunin ordinaire 01 copie_resized.png");
    img3b = loadImage("jpg/taux de participation au reunin ordinaire 02 copie_resized.png"); 
    img4 = loadImage("jpg/cadre de concertation 002 copie_resized.png");
    img5 = loadImage("jpg/recette fiscale 01_resized.png");
    img6 = loadImage("jpg/recette fiscale 02_resized.png");
    img7 = loadImage("jpg/recettes fiscales par tête d'habitant01_resized.png");
    img8 = loadImage("jpg/Recettes fiscales par tête d'habitant_resized.png");
    img9 = loadImage("jpg/plan de passassion de marche 01_resized.png");
    img10 = loadImage("jpg/plan de passassion de marche 02_resized.png");

    textFont(boldFont);
    
    //SECTION: Title
  
    fill(primaryColor);
    text(communeData.getString("label"), 77, 100);
    
    fill(textColor);
    textFont(lightFont);
    text("CAPACITÉ INSTITUTIONELLE", 77, 170);
    textAlign(RIGHT);
    text("MUNICIPALITÉ DE " + communeData.getString("commune"), 1883, 170);
    textAlign(LEFT);
    
    float middleX = (w - textWidth("MUNICIPALITÉ DE " + communeData.getString("commune")) - textWidth("CAPACITÉ INSTITUTIONELLE") - 400) * 0.5;
    
    //three dots FIXME
    noStroke();
    fill(highlightColor);
    for (int i = 0; i < 3; i = i+1) {
      ellipse(middleX + textWidth("CAPACITÉ INSTITUTIONELLE") + 200 + (i * 30) - ((3*30)/2) + 20, 150, 22, 22);
    }
    

     // original 1446, 434
    image(img1, 100, 335, 1018, 306);
    // original (868, 613)
    image(img2, 287.5, 865, 439, 306);
    // original (868, 613)
    image(img3, 1025, 865, 439, 306);
    image(img3b, 1485, 865, 439, 306);
    // original (1363, 613)
    image(img4, 287.5, 1395, 681, 306); 
    // originals (613, 434)
    image(img5, 100, 1880, 434, 306);
    image(img6, 554, 1880, 434, 306);       
    // originals (868, 613)
    image(img7, 1025, 1880, 439, 306);
    image(img8, 1485, 1880, 439, 306);    
    // originals (613, 434)
    image(img9, 100, 2300, 434, 306);
    image(img10, 554, 2300, 434, 306);      
    
    sectionHeader(215, "svg/building.svg", sections.getJSONObject(0).getString("label"),sections.getJSONObject(0).getFloat("points"),sections.getJSONObject(0).getFloat("max_points"));
    sectionHeader(725, "svg/council.svg", sections.getJSONObject(1).getString("label"),sections.getJSONObject(1).getFloat("points"),sections.getJSONObject(1).getFloat("max_points"));
    sectionHeader(1740, "svg/coins.svg", sections.getJSONObject(2).getString("label"),sections.getJSONObject(2).getFloat("points"),sections.getJSONObject(2).getFloat("max_points")); 
    
    personnel(sections.getJSONObject(0).getJSONObject("personnel"));
    
    //Nombre de sessions du Conseil Municipal tenues en 2014
    JSONObject jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      287, 1235, "");
   
    textFont(boldFont);
    textAlign(LEFT);
    textSize(25);
    text(jo.getString("label"), 287, 850);
   
    //Taux de participation aux réunions ordinaires du Conseil Municipal
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(1);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1200, 1235, "%");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(25);
    text(jo.getString("label"), 1025, 850);
  
    //Nombre de cadre de concertations organisés par la mairie en 2014
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(2);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1200, 1525, "");
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(25);
    text(jo.getString("label"), 287, 1380);
    
    //Taux du recouvrement des taxes en fonction de la population de la commune en 2014
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(0);
    scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      287, 2195, " FCFA"); */

    textFont(boldFont);
    textAlign(LEFT);
    textSize(25);
    text(jo.getString("label"), 287, 1865);

    //Taux du recouvrement de taxes en 2014 en fonction des prévisions
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(1);
    /*scale("",
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086, 2228, "%");*/
      
    textFont(boldFont);
    textAlign(LEFT);
    textSize(25);
    text(jo.getString("label"), 1087, 1865);
/*    
    //Taux d’exécution du plan de passation des marchés au cours de 2014
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086, 2456, "%");
    */
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
  stars(round(points/max * 5), yPos);
  
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

//SCALES
void scale(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  
  int scaleHeight = 40;
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
  
  rect(xPos + scaleX - 6,scaleY - 30,12,scaleHeight + 50);
  ellipse(xPos + scaleX,scaleY - 30,56,56);
  ellipse(xPos + scaleX,scaleY + 70,56,56);
  
  fill(0);
  textAlign(CENTER);

  
  textFont(boldFont);
  textSize(26);
  if(round(score) - score == 0){
    text(round(score),xPos + scaleX,scaleY - 20);
  }
  else{
    text(String.format("%.1f", score),xPos + scaleX,scaleY - 20);
  }
  
  
  textFont(lightFont);
  textSize(26);
  text(round(value),xPos + scaleX,scaleY + scaleHeight + 40);
  
  //top labels (points)
  textFont(boldFont);
  textSize(26);
  for (int i = 0; i < points.length; i = i+1) {
    //blank out label if close to score
    if(abs(value - scaleMarks[i]) > .1 * (max - min) && xPos + map(scaleMarks[i], min, max, 0, scaleWidth) != 0){
      text(str(points[i]), map(scaleMarks[i], min, max, 0, scaleWidth) + scaleX, scaleY - 20);
    }
  }
  text("pts.", scaleWidth + scaleX + 50, scaleY - 20);
  
  //bottom labels (scale marks)
  textFont(lightFont);
  textSize(26);
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

// people icons
void personnel(JSONObject peeps){
  person = loadShape("svg/person.svg");
  person.disableStyle();
  check = loadShape("svg/check.svg");
  
  fill(0);
  textFont(boldFont);
  textSize(35);
  text("Personnel de la municipalité remplissant l’organigramme type", 100, 685);
  
  textSize(20);
  textLeading(20);
  textAlign(CENTER);
  
  peep("Secrétaire", peeps.getBoolean("agent_secretaire"), 1200, 335);
  peep("Agent Etat Civil\net des Services\nStatistiques", peeps.getBoolean("agent_etat_civil"), 1400, 335);
  peep("Comptable", peeps.getBoolean("comptable"), 1600, 335);
  peep("Régisseur de\nRecettes", peeps.getBoolean("regisseur_recettes"), 1800, 335);
  peep("Agent de\nMatériel\nTransféré", peeps.getBoolean("agent_materiel_transfere"), 1200, 510);
  peep("Agent de\nServices\nStatistiques", peeps.getBoolean("agent_services_statistiques"), 1400, 510);
  peep("Agent de\nService\nTechnique", peeps.getBoolean("agent_service_techniques"), 1600, 510);
  peep("Agent de Service\ndes Affaires\nDomaniales\net Foncières", peeps.getBoolean("agent_affaires_domaniales_foncieres"), 1800, 510);

}

void peep(String title, Boolean filled, int x, int y){
  
  fill(0);
  // original (50, 240)
  text(title, x + 25, y + 125);
  if(filled) {
    noStroke();
    fill(primaryColor, 255);
  }
  else{
    stroke(primaryColor);
    strokeWeight(3);
    fill(255);
  }
  // original (85, 209)
  shape(person, x, y, 42, 104);
  if(filled){
    shape(check, x, y, 42, 104);
  }
  
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
    shape(star, gap * i + 1550, 2656 + 40);
    
  }
  
}