
#-------------------------------------------------------------------------------
# bearing and range available

"""
    $TYPEDEF

Bearing and Range constraint from a Pose2 to Point2 variable.
"""
mutable struct Pose2Point2BearingRange{B <: IIF.SamplableBelief, R <: IIF.SamplableBelief} <: IIF.AbstractRelativeMinimize
    bearing::B
    range::R
    Pose2Point2BearingRange{B,R}() where {B,R} = new{B,R}()
    Pose2Point2BearingRange{B,R}(x1::B,x2::R) where {B <: IIF.SamplableBelief,R <: IIF.SamplableBelief} = new{B,R}(x1,x2)
end
Pose2Point2BearingRange(x1::B,x2::R) where {B <: IIF.SamplableBelief,R <: IIF.SamplableBelief} = Pose2Point2BearingRange{B,R}(x1,x2)
function getSample(cfo::CalcFactor{<:Pose2Point2BearingRange}, N::Int=1)
  smpls = zeros(2, N)
  smpls[1,:] = rand(cfo.factor.bearing, N)[:]
  smpls[2,:] = rand(cfo.factor.range, N)[:]

  return (smpls,)
end

# define the conditional probability constraint
function (cfo::CalcFactor{<:Pose2Point2BearingRange})(res::AbstractVector{<:Real},
                                                      meas,
                                                      xi,
                                                      lm )
  #
  # FIXME, consolidate with parametric IIF #467

  # 1-bearing
  # 2-range

  # world frame
  θ = meas[1] + xi[3]
  mx = meas[2]*cos(θ)
  my = meas[2]*sin(θ)

  ex = lm[1] - (mx + xi[1])
  ey = lm[2] - (my + xi[2])
  
  # res = [eθ, er]
  res[1] = atan((my + xi[2]), (mx + xi[1])) - atan(lm[2], lm[1])  # eθ
  res[2] = sqrt(ex^2 + ey^2) # some wasted computation here       # er 

    # rot = meas[1]+xi[3]

    # res[1] = ( lm[1] - (meas[2]*cos( rot ) + xi[1]) )^2
    # res[2] = ( lm[2] - (meas[2]*sin( rot ) + xi[2]) )^2

    # res[1] += res[2]
    # res[2] = 0.0

    # return res[1]
    
    # IIF v0.21+
    nothing
end
# quick check
# pose = (0,0,0),  bear = 0.0,  range = 10.0   ==>  lm = (10,0)
# pose = (0,0,0),  bear = pi/2,  range = 10.0   ==>  lm = (0,10)
# pose = (0,0,pi/2),  bear = 0.0,  range = 10.0   ==>  lm = (0,10)
# pose = (0,0,pi/2),  bear = pi/2,  range = 10.0   ==>  lm = (-10,0)

#TODO wrapper, consolidate with CalcFactor version, see #467
function (s::Pose2Point2BearingRange{<:Normal})(xi::AbstractVector{T}, lm::AbstractVector{T}; kwargs...) where T <: Real


  meas = [mean(s.bearing), mean(s.range)]
  iΣ = [var(s.bearing)         0.0;
                  0.0  var(s.range)]

  # 1-bearing
  # 2-range

  # world frame
  θ = meas[1] + xi[3]
  mx = meas[2]*cos(θ)
  my = meas[2]*sin(θ)

  ex = lm[1] - (mx + xi[1])
  ey = lm[2] - (my + xi[2])
  er = sqrt(ex^2 + ey^2)

  eθ = atan((my + xi[2]), (mx + xi[1])) - atan(lm[2], lm[1])

  res = [eθ, er]

  return res' * iΣ * res

  # add to test
  # f = Pose2Point2BearingRange(Normal(0.0,1), Normal(10.0,1))
  # @test isapprox(f([0.,0,0], [10.,0]), 0, atol = 1e-9)
  # @test isapprox(f([0,0,pi/2], [0.,10]), 0, atol = 1e-9)
  #
  # f = Pose2Point2BearingRange(Normal(pi/2,1), Normal(10.0,1))
  # @test isapprox(f([0.,0,0], [0.,10]), 0, atol = 1e-9)
  # @test isapprox(f([0,0,pi/2], [-10.,0]), 0, atol = 1e-9)
  #
  # f = Pose2Point2BearingRange(Normal(pi,1), Normal(10.0,1))
  # @test isapprox(f([0.,0,0], [-10.,0]), 0, atol = 1e-9)
  # @test isapprox(f([0,0,pi/2], [0.,-10]), 0, atol = 1e-9)
  #
  # f = Pose2Point2BearingRange(Normal(-pi/2,1), Normal(10.0,1))
  # @test isapprox(f([0.,0,0], [0.,-10]), 0, atol = 1e-9)
  # @test isapprox(f([0,0,pi/2], [10.,0]), 0, atol = 1e-9)

end

# import RoME: Pose2Point2BearingRange


# Support for database based solving

passTypeThrough(d::FunctionNodeData{Pose2Point2Range}) = d

mutable struct PackedPose2Point2BearingRange <: IncrementalInference.PackedInferenceType
    bearstr::String
    rangstr::String
    PackedPose2Point2BearingRange() = new()
    PackedPose2Point2BearingRange(s1::AS, s2::AS) where {AS <: AbstractString} = new(string(s1),string(s2))
end

function convert(::Type{PackedPose2Point2BearingRange}, d::Pose2Point2BearingRange{B, R}) where {B <: IIF.SamplableBelief, R <: IIF.SamplableBelief}
  return PackedPose2Point2BearingRange(convert(PackedSamplableBelief, d.bearing), convert(PackedSamplableBelief, d.range))
end

# TODO -- should not be resorting to string, consider specialized code for parametric distribution types and KDEs
function convert(::Type{Pose2Point2BearingRange}, d::PackedPose2Point2BearingRange)
 # where {B <: IIF.SamplableBelief, R <: IIF.SamplableBelief}
  Pose2Point2BearingRange(convert(SamplableBelief, d.bearstr), convert(SamplableBelief, d.rangstr))
end
