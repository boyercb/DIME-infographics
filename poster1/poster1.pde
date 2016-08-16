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
  json = loadJSONArray("tabulated_data.json");
  
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
    text("CAPACITÉ INSTITUTIONELLE", 77, 200);
    textAlign(RIGHT);
    text("MUNICIPALITÉ DE " + communeData.getString("commune"), 1883, 200);
    textAlign(LEFT);
    
    float middleX = (w - textWidth("MUNICIPALITÉ DE " + communeData.getString("commune")) - textWidth("CAPACITÉ INSTITUTIONELLE") - 400) * 0.5;
    
    //three dots FIXME
    noStroke();
    fill(highlightColor);
    for (int i = 0; i < 3; i = i+1) {
      ellipse(middleX + textWidth("CAPACITÉ INSTITUTIONELLE") + 200 + (i * 30) - ((3*30)/2) + 20, 180, 22, 22);
    }
    
    sectionHeader(249, "building.svg", sections.getJSONObject(0).getString("label"),sections.getJSONObject(0).getFloat("points"),sections.getJSONObject(0).getFloat("max_points"));
    sectionHeader(938, "council.svg", sections.getJSONObject(1).getString("label"),sections.getJSONObject(1).getFloat("points"),sections.getJSONObject(1).getFloat("max_points"));
    sectionHeader(1795, "coins.svg", sections.getJSONObject(2).getString("label"),sections.getJSONObject(2).getFloat("points"),sections.getJSONObject(2).getFloat("max_points"));
    
    personnel(sections.getJSONObject(0).getJSONObject("personnel"));
    
    //Nombre de sessions du Conseil Municipal tenues en 2013
    JSONObject jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1111, "");
    
    //Taux de participation aux réunions ordinaires du Conseil Municipal
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(1);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1344, "%");
    
    //Nombre de cadre de concertations organisés par la mairie en 2013
    jo = sections.getJSONObject(1).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1581, "");
      
    //Taux du recouvrement des taxes en fonction de la population de la commune en 2013
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(0);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,1978, " FCFA");
      
    //Taux du recouvrement de taxes en 2013 en fonction des prévisions
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(1);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,2228, "%");
      
    //Taux d’exécution du plan de passation des marchés au cours de 2013
    jo = sections.getJSONObject(2).getJSONArray("items").getJSONObject(2);
    scale(jo.getString("label"),
      jo.getFloat("value"),
      jo.getFloat("score"),  
      jo.getJSONArray("points").getIntArray(), 
      jo.getJSONArray("scale_marks").getIntArray(),
      1086,2456, "%");
    
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

//SCALES
void scale(String label, float value, float score, int[] points, int[] scaleMarks, int scaleX, int scaleY, String scaleUnit){
  
  int scaleHeight = 50;
  int scaleWidth = 700;
  
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
  println("label" + label);
  println("x" + xPos);
  
  rect(xPos + scaleX - 6,scaleY - 30,12,scaleHeight + 50);
  ellipse(xPos + scaleX,scaleY - 30,63,63);
  ellipse(xPos + scaleX,scaleY + 80,63,63);
  
  fill(0);
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

// people icons
void personnel(JSONObject peeps){
  person = loadShape("person.svg");
  person.disableStyle();
  check = loadShape("check.svg");
  
  fill(0);
  textFont(boldFont);
  text("Personnel de la municipalité remplissant l’organigramme type", 300, 400);
  
  textSize(25);
  textLeading(30);
  textAlign(CENTER);
  
  peep("Secrétaire", peeps.getBoolean("agent_secretaire"), 200,550);
  peep("Agent etat Civil\net des Services\nStatistiques", peeps.getBoolean("agent_etat_civil"), 400,550);
  peep("Comptable", peeps.getBoolean("comptable"), 600,550);
  peep("Régisseur de\nRecettes", peeps.getBoolean("regisseur_recettes"), 800,550);
  peep("Agent de\nMatériel\nTransféré", peeps.getBoolean("agent_materiel_transfere"), 1000,550);
  peep("Agent de\nServices\nStatistiques", peeps.getBoolean("agent_services_statistiques"), 1200,550);
  peep("Agent de\nService\nTechnique", peeps.getBoolean("agent_service_techniques"), 1400,550);
  peep("Agent de Service\ndes Affaires\nDomaniales\net foncières", peeps.getBoolean("agent_affaires_domaniales_foncieres"), 1600,550);

}

void peep(String title, Boolean filled, int x, int y){
  
  fill(0);
  text(title, x + 50, y + 240);
  if(filled) {
    noStroke();
    fill(primaryColor, 255);
  }
  else{
    stroke(primaryColor);
    strokeWeight(3);
    fill(255);
  }
  shape(person, x,y);
  if(filled){
    shape(check, x,y);
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
  star = loadShape("star.svg");
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