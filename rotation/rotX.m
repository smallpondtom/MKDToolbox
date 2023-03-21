function R = rotX(phi,unit)
  arguments (Input)
    phi (1,1) {mustBeNumeric,mustBeReal}
    unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
  end

  arguments (Output)
    R (3,3) double
  end
  
  if unit == "rad"
    R = [1 0         0; 
         0 cos(phi)  sin(phi);
         0 -sin(phi) cos(phi)];
  else
    R = [1 0          0; 
         0 cosd(phi)  sind(phi);
         0 -sind(phi) cosd(phi)];
  end
end