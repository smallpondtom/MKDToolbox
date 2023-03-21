function R = rotY(theta,unit)
  arguments (Input)
    theta (1,1) {mustBeNumeric,mustBeReal}
    unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
  end

  arguments (Output)
    R (3,3) double
  end
  
  if unit == "rad"
    R = [cos(theta) 0 -sin(theta); 
         0          1 0;
         sin(theta) 0 cos(theta)];
  else
    R = [cosd(theta) 0 -sind(theta); 
         0           1 0;
         sind(theta) 0 cosd(theta)];
  end
end