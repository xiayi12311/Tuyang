VectorHelper = {}



function VectorHelper.Dot(v1, v2)

  return v1.X * v2.X + v1.Y * v2.Y + v1.Z * v2.Z

end



function VectorHelper.Mul(v1, v2)

  return Vector.New(v1.X * v2.X, v1.Y * v2.Y, v1.Z * v2.Z)

end



function VectorHelper.MulNumber(v1, number)

  return Vector.New(v1.X * number, v1.Y * number, v1.Z * number)

end



function VectorHelper.Sub(v1, v2)

  return Vector.New(v1.X - v2.X, v1.Y - v2.Y, v1.Z - v2.Z)

end



function VectorHelper.Add(v1, v2)

  return Vector.New(v1.X + v2.X, v1.Y + v2.Y, v1.Z + v2.Z)

end



function VectorHelper.ToString(v)

  return string.format("(%.2f,%.2f,%.2f)", v.X, v.Y, v.Z)

end



function VectorHelper.Cross(v1, v2)

  return Vector.New(v1.Y * v2.Z - v2.Y * v1.Z,

 v1.Z * v2.X - v2.Z * v1.X,

 v1.X * v2.Y - v2.X * v1.Y)

end



function VectorHelper.GetDistance(vector1, vector2)

  if vector1 == nil or vector2 == nil then return 0 end

  if vector1.X == nil or vector2.X == nil then return 0 end

  if vector1.Y == nil or vector2.Y == nil then return 0 end

  if vector1.Z == nil or vector2.Z == nil then return 0 end

  local disX = vector1.X - vector2.X

  local disY = vector1.Y - vector2.Y

  local disZ = vector1.Z - vector2.Z

  return math.sqrt(disX ^ 2 + disY ^ 2 + disZ ^ 2)

end



function VectorHelper.GetDistance2D(vector1, vector2)

  if vector1 == nil or vector2 == nil then return 0 end

  if vector1.X == nil or vector2.X == nil then return 0 end

  if vector1.Y == nil or vector2.Y == nil then return 0 end

  local disX = vector1.X - vector2.X

  local disY = vector1.Y - vector2.Y

  return math.sqrt(disX ^ 2 + disY ^ 2)

end



function VectorHelper.LengthSquared(v)

  return v.X ^ 2 + v.Y ^ 2 + v.Z ^ 2

end



function VectorHelper.Length(v)

  return math.sqrt(VectorHelper.LengthSquared(v))

end



function VectorHelper.ToLuaTable(v)

  return {X = v.X, Y = v.Y, Z = v.Z}

end



function VectorHelper.RotToLuaTable(v)

  return {Roll = v.Roll, Pitch = v.Pitch, Yaw = v.Yaw}

end



function VectorHelper.RotZero()

  return {Roll = 0, Pitch = 0, Yaw = 0}

end



function VectorHelper.ScaleOne()

  return {X = 1, Y = 1, Z = 1}

end

function VectorHelper.ChangePos(v)

  return {X = v.X, Y = v.Y, Z = v.Z -90}
  --return {X = v.X, Y = v.Y, Z = 0}

end




function VectorHelper.RandomVector(v, radius)

  local rx = math.random(-radius, radius);

  local ry = math.random(-radius, radius);

  return {X = v.X + rx, Y = v.Y + ry, Z = v.Z}

end



function VectorHelper.RandomRotatorYaw(r)

  local rz = math.random(-360, 360);

  return {Roll = r.Roll, Pitch = r.Pitch, Yaw = r.Yaw + rz}

end