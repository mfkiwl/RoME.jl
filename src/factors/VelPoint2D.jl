




"""
$(TYPEDEF)
"""
mutable struct VelPoint2VelPoint2{T <: IIF.SamplableBelief} <: IIF.AbstractRelativeMinimize
  Z::T
end

getManifold(::InstanceType{VelPoint2VelPoint2}) = TranslationGroup(4)

function (cfo::CalcFactor{<:VelPoint2VelPoint2})(z, xi, xj)
  #
  #FIXME JT - I'm createing new res for simplicity, it may not hold up well though
  res = Vector{eltype(xi)}(undef, 4)

  # change in time from microseconds with DynPoint2(ut=1_000_000) to seconds
  dt = Dates.value(cfo.fullvariables[2].nstime - cfo.fullvariables[1].nstime)*1e-9     # roughly the intended use of userdata
  # change in psoition Xi \ Xj
  dp = (xj[1:2] .- xi[1:2])
  # change in velocity Xi \ Xj
  dv = (xj[3:4] .- xi[3:4])

  dp_dt = dp./dt

  res[1:2] .= z[1:2] .- dp # (meas - predicted) change in position error term
  res[3:4] .= (z[3:4] .- dv).^2 # (meas - predicted) change in velocity error term

  # now cross couple the change in position information, via timestamps to accompanying velocity
  # TODO validate that 
  res[3:4] .+= (dp_dt - xi[3:4]).^2 # (meas - predicted) velocity error term
  res[3:4] .= sqrt.(res[3:4])

  return res
  # res[1] = 0.0
  # res[1] += sum((Z[1:2] - dp).^2) # (meas - predicted) change in position error term
  # res[1] += sum((Z[3:4] - dv).^2) # (meas - predicted) change in velocity error term

  # ## now cross couple the change in position information, via timestamps to accompanying velocity
  #  # recompute integration of velocity influence
  # # forward diff, "measured velocity"
  # # zeroth order integration
  # res[1] += sum((dp_dt - xi[3:4]).^2) # (meas - predicted) velocity error term

    # first order integration
    # res[1] += sum((dp/dt - 0.5*(xj[3:4]+xi[3:4])).^2)

  # return objective cost < IIF v0.21
  # return res[1]

  # IIF v0.21+
  # return residual
end



"""
$(TYPEDEF)
"""
Base.@kwdef struct PackedVelPoint2VelPoint2 <: AbstractPackedFactor
  Z::PackedSamplableBelief
end

function convert(::Type{PackedVelPoint2VelPoint2}, d::VelPoint2VelPoint2)
  return PackedVelPoint2VelPoint2(convert(PackedSamplableBelief, d.Z))
end
function convert(::Type{VelPoint2VelPoint2}, d::PackedVelPoint2VelPoint2)
  return VelPoint2VelPoint2(convert(SamplableBelief, d.Z))
end
