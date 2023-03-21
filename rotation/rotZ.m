function R = rotZ(psi,unit)
  arguments (Input)
    psi (1,1) {mustBeNumeric,mustBeReal}
    unit (1,1) string {mustBeMember(unit,["rad","deg"])} = "rad"
  end

  arguments (Output)
    R (3,3) double
  end
  
  if unit == "rad"
    R = [cos(psi)  sin(psi) 0;
         -sin(psi) cos(psi) 0
         0         0        1];
  else
    R = [cosd(psi)  sind(psi) 0;
         -sind(psi) cosd(psi) 0
         0         0          1];
  end
end