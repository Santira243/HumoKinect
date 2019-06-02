

ParticleSystem ps,ps2;
import KinectPV2.KJoint;
import KinectPV2.*;

KinectPV2 kinect;

PVector manoIzq;
PVector manoDer;
int maxD = 2000; // 2.0 m
int minD = 700;  //  50 cm

void setup() {
  size(displayWidth, displayHeight);
  PImage img = loadImage("sprite.png");
  ps = new ParticleSystem(1, new PVector(width/2-100, height/2), img);
  ps2 = new ParticleSystem(1, new PVector(width/2+100, height/2), img);

  kinect = new KinectPV2(this);

  kinect.enableColorImg(true);

  //enable 3d  with (x,y,z) position
  kinect.enableSkeleton3DMap(true);

  kinect.init();

}

void draw() {
  background(0);
   kinect.setLowThresholdPC(minD);
  kinect.setHighThresholdPC(maxD);   
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
  
   for (int i = 0; i < skeletonArray.size(); i++) {
     //SOLO 1
     if(i==0){
     
     KSkeleton skeleton = (KSkeleton) skeletonArray.get(i);
 
   if (skeleton.isTracked()) {
      KJoint[] joints = skeleton.getJoints();

      //draw different color for each hand state
      drawHandState(joints[KinectPV2.JointType_HandRight],-1);
      drawHandState(joints[KinectPV2.JointType_HandLeft],1);
      ps.move(manoIzq);
      ps2.move(manoDer);
      ps2.applyForce(); 
      ps2.run();
      ps.applyForce(); 
      ps.run();
      for (int ia = 0; ia < 5; ia++) {
      ps.addParticle();
      ps2.addParticle(); 
      }
  
 }
   }
   }

  // Draw an arrow representing the wind force
}

void drawHandState(KJoint joint, int lado) {
  noStroke();
  handState(joint.getState());

  if(lado == -1){
  manoDer = new PVector(map(joint.getX(),-1.5,1.5,0,displayWidth), map(joint.getY(),-.5,.5,displayHeight,0));}
  if(lado == 1){
  manoIzq = new PVector(map(joint.getX(),-1.5,1.5,0,displayWidth), map(joint.getY(),-.5,.5,displayHeight,0));}
  
// println(map(joint.getX(),-1.5,1.5,0,displayWidth), map(joint.getY(),-.5,.5,displayHeight,0), map(joint.getZ(),-1.5,1.5,-20,0));
// println(joint.getX(),joint.getY(),joint.getZ());

//  point(joint.getX(), joint.getY(), joint.getZ())
}

void handState(int handState) {
  switch(handState) {
  case KinectPV2.HandState_Open:
    //stroke(0, 255, 0);
    fill(0,255,0);
    break;
  case KinectPV2.HandState_Closed:
    //stroke(255, 0, 0);
    fill(255,0,0);
    break;
  case KinectPV2.HandState_Lasso:
    //stroke(0, 0, 255);
   fill(0,0,255);
    break;
  case KinectPV2.HandState_NotTracked:
    //stroke(100, 100, 100);
    break;
  }
}
