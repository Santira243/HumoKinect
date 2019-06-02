// A class to describe a group of Particles
// An ArrayList is used to manage the list of Particles 

class ParticleSystem {

  ArrayList<Particle> particles;    // An arraylist for all the particles
  PVector origin;                   // An origin point for where particles are birthed
  PImage img;
   
  ParticleSystem(int num, PVector v, PImage img_) {
    particles = new ArrayList<Particle>();              // Initialize the arraylist
    origin = v.copy();// Store the origin point
    img = img_;
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(origin, img));         // Add "num" amount of particles to the arraylist
    }
  }
  void move( PVector mo){
  origin = mo;
  }
  void run() {
    for (int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.isDead()) {
        particles.remove(i);
      }
    }
  }

  // Method to add a force vector to all particles currently in the system
  void applyForce() {
    // Enhanced loop!!!
    for (Particle p : particles) {
      //p.applyForce(dir);
      PVector aux_dir;
      aux_dir = new PVector(random(-0.5,0.5),random(-0.5,0.5));
      p.applyForce(aux_dir);
    }
  }  

  void addParticle() {
    PVector aux;
    aux = new PVector(0,0);
    aux.x= random(-5,5)+origin.x;
    aux.y= random(-5,5)+origin.y;
    particles.add(new Particle(aux, img));
  }
}
