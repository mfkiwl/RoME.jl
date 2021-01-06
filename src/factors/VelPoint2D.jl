




"""
$(TYPEDEF)
"""
mutable struct VelPoint2VelPoint2{T <: IIF.SamplableBelief} <: IIF.AbstractRelativeMinimize
  z::T
  VelPoint2VelPoint2{T}() where {T <: Distribution} = new{T}()
  VelPoint2VelPoint2{T}(z1::T) where {T <: Distribution} = new{T}(z1)
end
VelPoint2VelPoint2(z1::T) where {T <: Distribution} = VelPoint2VelPoint2{T}(z1)
getSample(cfo::CalcFactor{<:VelPoint2VelPoint2}, N::Int=1) = (rand(cfo.factor.z,N), )
function (cfo::CalcFactor{<:VelPoint2VelPoint2})(
                res::AbstractVector{<:Real},
                z,
                xi,
                xj  )
  #
  # change in time from microseconds with DynPoint2(ut=1_000_000) to seconds
  dt = Dates.value(cfo.metadata.fullvariables[2].nstime - cfo.metadata.fullvariables[1].nstime)*1e-9     # roughly the intended use of userdata
  # change in psoition Xi \ Xj
  dp = (xj[1:2]-xi[1:2])
  # change in velocity Xi \ Xj
  dv = (xj[3:4]-xi[3:4])
  res[1] = 0.0
  res[1] += sum((z[1:2] - dp).^2) # (meas - predicted) change in position error term
  res[1] += sum((z[3:4] - dv).^2) # (meas - predicted) change in velocity error term

  ## now cross couple the change in position information, via timestamps to accompanying velocity
   # recompute integration of velocity influence
  # forward diff, "measured velocity"
  dp_dt = dp./dt
  # zeroth order integration
  res[1] += sum((dp_dt - xi[3:4]).^2) # (meas - predicted) velocity error term

    # first order integration
    # res[1] += sum((dp/dt - 0.5*(xj[3:4]+xi[3:4])).^2)

  # return objective cost
  return res[1]
end



"""
$(TYPEDEF)
"""
mutable struct PackedVelPoint2VelPoint2 <: IncrementalInference.PackedInferenceType
  str::String
  PackedVelPoint2VelPoint2() = new()
  PackedVelPoint2VelPoint2(z1::String) = new(z1)
end

function convert(::Type{PackedVelPoint2VelPoint2}, d::VelPoint2VelPoint2)
  return PackedVelPoint2VelPoint2(convert(PackedSamplableBelief, d.z))
end
function convert(::Type{VelPoint2VelPoint2}, d::PackedVelPoint2VelPoint2)
  distr = convert(SamplableBelief, d.str)
  return VelPoint2VelPoint2(distr)
end
