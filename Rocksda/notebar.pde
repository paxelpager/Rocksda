class notebar {
  
  int channel;
  int note;
  int velocity;
  
  float selfskor=0;
  
  
  int y;
  float x;
  int sutun;
  color renk;
  PVector location;
  PVector hizvec;
  
  float period;
  boolean dead;
  int hiz;
  float ctime;
  int id;
  boolean turn = false; 
  
  // Raylılar için değişken alanı
  float raY;
  float raT;
  boolean rayli; // notebarın tipini belirlemek için
  boolean rayda = false; // raylı notebara basılıyor mu
  
  boolean kontak=false; //sahneye çıkınca durmaması için (giriş vakti tek, diğer vakitlerde de hareket edebilmesi için)
  
  notebar[] others;
  
  notebar(int idin ,int sutun_, int hiz_, float sira_, float peri/*duraqtion*/) {
    sutun = sutun_;
    if(sutun!=-1){
      x = horPos(sutun, sutunWidth)+(sutunWidth/2);
      renk = teamRenk[sutun];
    }else{dead=true;}
    hiz = hiz_;
    ctime = sira_;
    id = idin;
    y = passin;
    period = peri;
    
    location = new PVector(x, y);
    hizvec = new PVector(0, hiz);
    
    raT = ctime + peri;
    rayli = peri>perlimit?  true:false  ;
  }


  void motor() {
      if(!dead){
        if(clock.time() >= ctime) {kontak = true;}
        if(kontak){
          //println(id +" : "+ctime);
          update();
          Display();
        }
      }
  }
 
  void Display() {
    if(rayli){
      stroke(0);
      strokeWeight(40);
      line(x, location.y, x, raY);
      stroke(renk);
      strokeWeight(20);
      line(x, location.y, x, raY+10);
    }
      fill(renk);
      stroke(0);
      strokeWeight(7);
      circle(location.x, location.y, 100);
      strokeWeight(1);
  }
 
 
 
    void kill(){
      accesskey[sutun] = false;
      handylist[sutun] = false;
      dead = true;
      kontak = false;
      turn = false;
      location.x = 2000;
  }
  

  void update() {
    if(turn){
      if (location.y>passout) {scoreC = -25;  score -= 25;  kill();}// kaçanı vuruyoz     
      
      if (handylist[sutun]) {
        if(!rayli){
          skorhesap();
          kill();
        }else{
          skorhesap();
          if(raY>=location.y){
            kill();
          }
        }
    }
   }
    
    if(rayli){
      if(handylist[sutun]&&turn){  hizvec.y=0; }
      
      if(hizvec.y == 0 &&!handylist[sutun]&&kontak){
        kill();
        scoreC = -25;
        score -= 25;
      }
      
      if(clock.time() >= raT){raY += hiz;} else { raY = passin;}
      location.add(hizvec);
    
    }else{location.add(hizvec);}
  }
  
  void skorhesap(){
  fill(#08C909);
  textSize(40);
  textAlign(CENTER);
  fark = abs((passout-100) - location.y);
  if(!rayli){
    if (fark>150) {
      score-=20;
      scoreC= -20;
    } else if (fark>15) {
      score +=10;
      scoreC = 10;
    } else {
      score +=20;
      scoreC =20;
    }
  }else{
    if (fark>150) {
      score-=25;
      scoreC-=25;
      kill();
    } else if (fark>15) {
      score +=0.5;
      selfskor+=0.5;
      scoreC = 0.5;
    } else {
      score +=1;
      selfskor+=1;
      scoreC = 1;
      
      
    }
  }
 }
  
}
