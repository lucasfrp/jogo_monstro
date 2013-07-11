import ddf.minim.*;

class Janela {
 private int num_janelas; 
 protected int id;
 private PApplet app;
 private Minim minim;
 private boolean trancada = false;
 private String url_janela;
 private PImage imagem_janela;
 protected AudioPlayer som_janela_click; 
  
 Janela(PApplet papp, int janelas, int id_janela){
   this(papp, janelas, id_janela, "janelaFechada.jpg");
 }   
 
 Janela(PApplet papp, int janelas, int id_janela, String url_janela){
   minim = new Minim(papp);
   app = papp;
   id = id_janela;
   setNumJanelas(janelas);
   setUrlJanela(url_janela);
   setImgJanela(loadImage(getUrlJanela()));
   imagem_janela.resize(getNewWidth(),0);
   som_janela_click = minim.loadFile("person_knocks_once_on_hollow_wooden_door.mp3");
 }
 
 private int getNewWidth(){
  return imagem_janela.width / ((int)Math.sqrt(num_janelas));  
 }
 
 private int getX(){   
   int colunas = (int)Math.sqrt(num_janelas); 
   int coluna = getId() % colunas;
   if (coluna == 0) { coluna = colunas;}
   return getImgJanela().width * (coluna-1);
 }
 
 public int getY(){
   float colunas = (int)Math.sqrt(num_janelas);
   int linha = ceil(getId() / colunas);
   return getImgJanela().height * (linha -1);
 }
 
 private void setNumJanelas(int n){
   num_janelas = n;
 }
 
 private int getId(){
   return id;
 }
 
 public void setUrlJanela(String url){
   url_janela = url; 
 }
 
 public String getUrlJanela(){
   return url_janela; 
 }
  
 public void setImgJanela(PImage imagem){
   imagem_janela = imagem; 
 }
 
 public void setImgJanela(String url){
   setUrlJanela(url);
   setImgJanela(loadImage(getUrlJanela())); 
 }
 
 public PImage getImgJanela(){
   return imagem_janela; 
 }
 
 public boolean estaFechada(){
  return true; 
 }
 
 public boolean estaTrancada(){
   return trancada;
 }
 
 public void trancaJanela(){
  trancada = true; 
 }
 
 boolean podeAbrir(){
  return (estaFechada() && !estaTrancada()); 
 }
 
 void exibe(){
   image(imagem_janela,getX(),getY());  
 }
 
 void fecha_janela(){
   trancada = false;
   this.exibe();
//   return this;
 }
 
 Janela exibe_aleatorio(){
   Janela retorno;
   int aleatorio = int(random(2));
   if (aleatorio == 0){
     retorno = new Crianca(app, getId(), minim);
   } else if(aleatorio == 1) {
     retorno = new Monstro(app, getId(), minim);
   } else {
     retorno = new Janela(app, num_janelas, id);
   }   
   retorno.exibe();
   println(retorno.getClass().getName());
   return retorno;
 }

 void click(){
   som_janela_click.rewind();   
   som_janela_click.play();
 }
 
}
 
class JanelaAberta extends Janela{
  
  protected AudioPlayer som_janela;
  
  JanelaAberta(PApplet papp, int janela_id, String url_janela){
    super(papp, num_janelas, janela_id, url_janela);
  }
  
//  Janela fecha_janela(){
////    Janela retorno = new Janela(app, num_janelas, id);
//    super.exibe();
////    return super;
//  }
  
  void exibe(){
    super.exibe();
    som_janela.play(); 
  }
  
  boolean estaFechada(){
    return false;
  }
}

class Monstro extends JanelaAberta{
  
  Monstro(PApplet papp, int id_janela, Minim minim){
    super(papp, id_janela, "janelaMonstro.jpg");
    som_janela = minim.loadFile("monster_or_large_creature_groan[2].mp3");
    som_janela_click = minim.loadFile("magic_spell_trick_sound_002.mp3");
  } 
}

class Crianca extends JanelaAberta{
 
  Crianca(PApplet papp, int id_janela, Minim minim){
    super(papp, id_janela, "janelaCrianca.jpg");
    som_janela = minim.loadFile("scream_high_female[2].mp3");
    som_janela_click = minim.loadFile("female_grunt_could_be_in_pain_or_anger.mp3");
  } 
}
