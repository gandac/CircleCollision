
class Circle{
    public PeasyGradients peasyGradients;
    public PVector location;
    // Vector dir;
    PGraphics ellipse, ellipseMask;
    int rad;
    float xDirection = random( -1.00,1.00);
    float yDirection = random( -1.00,1.00);
    PVector velocity = new PVector(random( -initialSpeed, initialSpeed),random( -initialSpeed, initialSpeed));
    PVector acceleration = new PVector(0, 0);
    
    
    // constructor
    Circle(PVector lc,int radius,PeasyGradients p) {
        location = lc;
        rad = radius;
        peasyGradients = p;
        
        this.setup();
    }
    
    void checkCollisionWith(Circle otherCircle) {
        PVector other = otherCircle.location;
        float distanceBetweenCircles = this.rad + otherCircle.rad;   
        boolean isColliding = isColliding(this,otherCircle);
        PVector distanceVector = PVector.sub(other, location);
        float distanceVectorMag = distanceVector.mag();
        
        // is colliding
        if (distanceVectorMag <  distanceBetweenCircles) {
            float m = rad * 0.1;
            float otherM = otherCircle.rad * 0.1;
            
            float distanceCorrection = (distanceBetweenCircles - distanceVectorMag) / 2.0;
            PVector d = distanceVector.copy();
            PVector correctionVector = d.normalize().mult(distanceCorrection);
            otherCircle.location.add(correctionVector);
            location.sub(correctionVector);
            // get angle of distanceVect
            float angle  = distanceVector.heading();
            float sinAngle = sin(angle);
            float cosAngle = cos(angle);
            
            PVector[] bTemp = {
                new PVector(), new PVector()
                };
            bTemp[1].x = cosAngle * distanceVector.x + sinAngle * distanceVector.y;
            bTemp[1].y = cosAngle * distanceVector.y - sinAngle * distanceVector.x;
            
            PVector[] vTemp = {
                new PVector(), new PVector()
                };
            
            // rotate velocities
            vTemp[0].x  = cosAngle * velocity.x + sinAngle * velocity.y;
            vTemp[0].y  = cosAngle * velocity.y - sinAngle * velocity.x;
            vTemp[1].x  = cosAngle * otherCircle.velocity.x + sinAngle * otherCircle.velocity.y;
            vTemp[1].y  = cosAngle * otherCircle.velocity.y - sinAngle * otherCircle.velocity.x;
            
            PVector[] vFinal = {
                new PVector(), new PVector()
                };
            
            // final rotated velocity for this ball
            vFinal[0].x = ((m - otherM) * vTemp[0].x + 2 * otherM * vTemp[1].x) / (m + otherM);
            vFinal[0].y = vTemp[0].y;
            
            // final rotated velocity for b[0]
            vFinal[1].x = ((otherM - m) * vTemp[1].x + 2 * m * vTemp[0].x) / (m + otherM);
            vFinal[1].y = vTemp[1].y;
            
            
            velocity.x = cosAngle * vFinal[0].x - sinAngle * vFinal[0].y;
            velocity.y = cosAngle * vFinal[0].y + sinAngle * vFinal[0].x;
            otherCircle.velocity.x = cosAngle * vFinal[1].x - sinAngle * vFinal[1].y;
            otherCircle.velocity.y = cosAngle * vFinal[1].y + sinAngle * vFinal[1].x;
        }
    }
    
    void checkBoundaries() {
        if (location.x + rad > width || location.x - rad < 0) {
            velocity.x = -velocity.x;
        }
        if (location.y + rad > height || location.y - rad < 0) {
            velocity.y = -velocity.y;
        }
    }
    
    Circle update() {
        
        for (Circle circle : circles) {
            if (circle != this) {
                checkCollisionWith(circle);
            }
        }
        
        checkBoundaries();
        
        return this;
    }
    
    void setup() {
        int diameter = rad * 2;
        int r = floor(100 + random(105)),g = floor(100 + random(105)),b = floor(100 + random(105));
        
        Gradient pinkToYellow = new Gradient(color(255),color(r + 25, g + 25, b + 25), color(r, g, b), color(r - 50,g - 50,b - 50), color(0));
        ellipse = createGraphics(diameter, diameter);
        peasyGradients.setRenderTarget(ellipse);
        peasyGradients.radialGradient(pinkToYellow, new PVector(rad , rad), 0.5);
        ellipseMask = createGraphics(diameter, diameter);
        ellipseMask.beginDraw();
        ellipseMask.fill(255); // keep white pixels
        ellipseMask.circle(rad, rad,diameter);
        ellipseMask.endDraw();
        ellipse.mask(ellipseMask);
    }
    
    void draw() {
        
        // blendMode(SCREEN);
        // shader(bwShader);
        velocity.add(acceleration);
        velocity.limit(initialSpeed);
        location.add(velocity);
        
        // ellipse(location.x,location.y,rad * 2, rad * 2);
        
        image(ellipse,location.x - rad, location.y - rad,rad * 2,rad * 2);
        // fill(r,g,b);
        
    }
}
