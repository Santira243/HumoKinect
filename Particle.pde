
// A simple Particle class, renders the particle as an image

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;
  //PImage img;
  PImage sprite;  
  //float partSize = 20;

  Particle(PVector l, PImage img_) {
    acc = new PVector(0, 0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    vel = new PVector(vx, vy);
    loc = l.copy();
    lifespan = 100.0;
   // img = img_;
    sprite = img_;
  }

  void run() {
    update();
    render();
  }

  // Method to apply a force vector to the Particle object
  // Note we are ignoring "mass" here
  void applyForce(PVector f) {
    acc.add(f);
  }  

  // Method to update position
  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 1.4;
    acc.mult(0); // clear Acceleration
  }

  // Method to display
  void render() {
    imageMode(CENTER);
    tint(0, 153, 204, lifespan);  // Tint blu
    //tint(255, lifespan);
    image(sprite, loc.x, loc.y);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan <= 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
