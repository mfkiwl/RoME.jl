

##==============================================================================
## Legacy, remove some time after DFG v0.20
##==============================================================================

# function getSample(cf::CalcFactor{<:MutablePose2Pose2Gaussian})
#   Xc = rand(cf.factor.Z)

#   M = SpecialEuclidean(2)
#   X = hat(M, Manifolds.Identity(M), Xc)
#   return X
# end

# getSample(cfo::CalcFactor{<:VelPoint2VelPoint2}) = rand(cfo.factor.Z)

# function getSample(cfo::CalcFactor{<:Pose2Point2Range})
#   return rand(cfo.factor.Z)
# end

# function getSample(cfo::CalcFactor{<:Point2Point2Range})
#   return rand(cfo.factor.Z)
# end

# function getSample(cf::CalcFactor{<:PriorPose2})
#   Z = cf.factor.Z
#   p = cf.factor.p
#   M = getManifold(cf.factor)
  
#   Xc = rand(Z)
  
#   # X = get_vector.(Ref(M), Ref(p), Xc, Ref(DefaultOrthogonalBasis()))
#   X = hat(M, p, Xc)
#   points = exp(M, p, X)

#   return points
# end

# PriorPose2{T,P}(z::IIF.SamplableBelief) where {T,P} = PriorPose2{T,P}(z, getPointIdentity(Pose2))

# convenience and default constructor
# Pose3Pose3() = Pose3Pose3(MvNormal(zeros(6),LinearAlgebra.diagm([0.01*ones(3);0.0001*ones(3)])))

# # convenience and default object helper
# PriorPose3(z::IIF.SamplableBelief) = PriorPose3(Z=z)

# Standardized sampling function
# function getSample(cf::CalcFactor{<:PriorPose3}, N::Int=1)
#   Z = cf.factor.Z
#   p = cf.factor.p
#   M = getManifold(cf.factor)
  
#   Xc = rand(Z)
  
#   # X = get_vector.(Ref(M), Ref(p), Xc, Ref(DefaultOrthogonalBasis()))
#   X = hat(M, p, Xc)
#   points = exp(M, p, X)

#   return points
# end

# PriorPose3{T,P}(z::IIF.SamplableBelief) where {T,P} = PriorPose3{T,P}(z, getPointIdentity(Pose3))
# PriorPose3() = PriorPose3(MvNormal(zeros(6), LinearAlgebra.diagm([0.01*ones(3);0.0001*ones(3)])))

# prescribed sampling function
# function getSample(cfo::CalcFactor{<:Pose2Point2}, N::Int=1)
#   return rand(cfo.factor.Z)
# end

# PriorPose2(Z::IIF.SamplableBelief) = PriorPose2(;Z)

# convenience and default constructor
# Pose2Pose2() = Pose2Pose2(MvNormal(Diagonal([1.0; 1.0; 1.0])))

# convenience and default object helper
# Point2Point2(x::T=MvNormal(zeros(2),LinearAlgebra.diagm([0.1;0.1]))) where {T <: IIF.SamplableBelief} = Point2Point2{T}(x)

# convenience and default object helper
# PriorPolar(zr::T1=Normal(1,1), za::T2=Normal(0,0.1)) where {T1 <: IIF.SamplableBelief,T2 <: IIF.SamplableBelief} = PriorPolar{T1,T2}(zr,za)

# convenience and default object helper
# PolarPolar(zr::T1=Normal(1,1), za::T2=Normal(0,0.1)) where {T1 <: IIF.SamplableBelief,T2 <: IIF.SamplableBelief} = PolarPolar{T1,T2}(zr,za)

# Polar() = new(2,(:Euclid,:Circular))

# convenience and default object helper
# Point3Point3(x::T=MvNormal(zeros(3),LinearAlgebra.diagm([0.1;0.1;0.1]))) where {T <: IIF.SamplableBelief} = Point3Point3(x)

# function getSample(cfo::CalcFactor{<:Point3Point3})
#   return rand(cfo.factor.Z)
# end

# function getSample(p3::PriorPoint3)
#   return (rand(p3.Z),)
# end

# function getSample(cfo::CalcFactor{<:Point2Point2})
#   return rand(cfo.factor.Z)
# end

# convenience helper and default object
# PriorPoint2() = PriorPoint2(MvNormal(zeros(2),LinearAlgebra.diagm([0.01;0.01])))

# function getSample(cfo::CalcFactor{<:PriorPoint2})
#   return rand(cfo.factor.Z)
# end

#TODO what is this, can it be removed? Moved here from above

# """
# Converter: PriorPose3ZRP::Dict{String, Any} -> PriorPose3ZRP

# DevNotes
# - FIXME drop _evalType approach, use convert(SamplableBelief, obj) instead?
# """
# function convert(::Type{<:PriorPose3ZRP}, fact::Dict{String, Any})
#     rp = fact["measurement"][1]
#     z = fact["measurement"][2]
#     # FIXME drop _evalType
#     rp = convert(_evalType(rp["distType"]), rp)
#     z = convert(_evalType(z["distType"]), z)
#     return PriorPose3ZRP(rp, z)
# end

# """
# Converter: PriorPose3ZRP::Dict{String, Any} -> PriorPose3ZRP
# """
# function convert(::Type{Dict{String, Any}}, fact::PriorPose3ZRP)
#     pf = Dict{String, Any}(
#         "measurement" => [
#             convert(Dict{String, Any}, fact.rp),
#             convert(Dict{String, Any}, fact.z)
#         ],
#         "factorType" => "PriorPose3ZRP"
#     )
#     return pf
# end

# """
#     $SIGNATURES

# Converter: Dict{String, Any} -> Pose3Pose3XYYaw
# """
# function convert(::Type{Dict{String, Any}}, fact::Pose3Pose3XYYaw)
#     pf = Dict{String, Any}(
#         "measurement" => [
#             convert(Dict{String, Any}, fact.xy),
#             convert(Dict{String, Any}, fact.yaw)
#         ],
#         "factorType" => "Pose3Pose3XYYaw"
#     )
#     return pf
# end

# """
#     $SIGNATURES

# Converter: Pose3Pose3XYYaw -> Dict{String, Any}

# DevNotes
# - FIXME stop using _evalType, see DFG #590
# """
# function convert(::Type{<:Pose3Pose3XYYaw}, fact::Dict{String, Any})
#     xy = fact["measurement"][1]
#     yaw = fact["measurement"][2]
#     xy = convert(_evalType(xy["distType"]), xy)
#     yaw = convert(_evalType(yaw["distType"]), yaw)
#     return PriorPose3ZRP(xy, yaw)
# end


# function getSample(cf::CalcFactor{<:Pose3Pose3XYYaw})
#   return sampleTangent(getManifold(cf.factor), cf.factor.Z)
# end

# getManifolds(::Type{DynPose2DynPose2}) = (:Euclid,:Euclid,:Circular,:Euclid,:Euclid)
# getManifolds(::DynPose2DynPose2) = getManifolds(DynPose2DynPose2)
# getSample(ip3::InertialPose3) = rand( ip3.Z)
# DynPose2Pose2(z1::T) where {T <: IIF.SamplableBelief} = DynPose2Pose2{T}(z1)
# getSample(cfo::CalcFactor{<:Point2Point2Velocity}) = rand(cfo.factor.Z)
# getSample(cfo::CalcFactor{<:DynPoint2DynPoint2}) = rand(cfo.factor.Z)
# DynPoint2VelocityPrior(z1::T) where {T <: SamplableBelief} = DynPoint2VelocityPrior{T}(z1)
# getSample(cfo::CalcFactor{<:DynPoint2VelocityPrior}) = rand(cfo.factor.Z)



##==============================================================================
## Legacy, remove some time after DFG v0.19
##==============================================================================

@deprecate generateCanonicalFG_Helix2DSlew!(w...;kw...) generateGraph_Helix2DSlew!(w...;kw...)
@deprecate generateCanonicalFG_Helix2DSpiral!(w...;kw...) generateGraph_Helix2DSpiral!(w...;kw...)
@deprecate generateCanonicalFG_Helix2D!(w...;kw...) generateGraph_Helix2D!(w...;kw...)
@deprecate generateCanonicalFG_Honeycomb!(w...;kw...) generateGraph_Honeycomb!(w...;kw...)
@deprecate generateCanonicalFG_Beehive!(w...;kw...) generateGraph_Beehive!(w...;kw...)
@deprecate generateCanonicalFG_TwoPoseOdo(w...;kw...) generateGraph_TwoPoseOdo(w...;kw...)
@deprecate generateCanonicalFG_Boxes2D!(w...;kw...) generateGraph_Boxes2D!(w...;kw...)
@deprecate generateCanonicalFG_Hexagonal(w...;kw...) generateGraph_Hexagonal(w...;kw...)
@deprecate generateCanonicalFG_ZeroPose(w...;kw...) generateGraph_ZeroPose(w...;kw...)
@deprecate generateCanonicalFG_Circle(w...;kw...) generateGraph_Circle(w...;kw...)


# getManifold(::IIF.InstanceType{Pose3Point3}) = Point3
# getManifold(::IIF.InstanceType{Pose2Point2BearingRange}) = BearingRange2 |> getManifold

function Base.getproperty(pp::Pose2Pose2, f::Symbol)
  if f == :z
    @warn "Pose2Pose2.z is deprecated, use Pose2Pose2.Z instead" maxlog=10
    pp.Z
  else
    getfield(pp, f)
  end
end


##==============================================================================
## Remove as part of Manifolds.jl consolidation, #244
##==============================================================================

export veePose3, veePose

function veePose3(s::SE3)
  TransformUtils.veeEuler(s)
end
function veePose(s::SE3)
  TransformUtils.veeEuler(s)
end


# legacy support, will be deprecated
Base.convert(::Type{<:Tuple}, ::IIF.InstanceType{typeof(AMP.SE2_Manifold)}) = (:Euclid, :Euclid, :Circular)
Base.convert(::Type{<:Tuple}, ::IIF.InstanceType{typeof(SE2E2_Manifold)}) = (:Euclid,:Euclid,:Circular,:Euclid,:Euclid)
Base.convert(::Type{<:Tuple}, ::IIF.InstanceType{typeof(BearingRange_Manifold)}) = (:Circular,:Euclid)

Base.convert(::Type{<:Tuple}, ::IIF.InstanceType{typeof(Manifolds.ProductGroup(ProductManifold(SpecialEuclidean(2), TranslationGroup(2))))}) = (:Euclid,:Euclid,:Circular,:Euclid,:Euclid)


Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Point2Point2}) = AMP.Euclid2
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose2Point2}) = AMP.Euclid2
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose2Point2Bearing}) = AMP.Euclid
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Point2Point2Range}) = AMP.Euclid
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose2Point2Range}) = AMP.Euclid
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose2Point2BearingRange}) = AMP.Euclid2
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose2Pose2}) = AMP.SE2_Manifold
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{Pose3Pose3}) = AMP.SE3_Manifold
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{DynPoint2DynPoint2}) = AMP.Euclid4
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{DynPose2DynPose2}) = SE2E2_Manifold
Base.convert(::Type{<:ManifoldsBase.AbstractManifold}, ::IIF.InstanceType{VelPose2VelPose2}) = SE2E2_Manifold



##==============================================================================
## OLD Victory Park Example code, don't delete until replacements are coded
##==============================================================================



# function projNewLandmPoints(vps::Graphs.ExVertex, br::Array{Float64,1}, cov::Array{Float64,2})
#   # TODO -- convert to use Distributions and common projection function
#   Xps = getVal(vps)
#   lmPts = zeros(2,size(Xps,2))
#   for i in 1:size(Xps,2)
#       ent = [cov[1,1]*randn(); cov[2,2]*randn()]
#       init = vec(Xps[1:2,i])+randn(2)
#       lmPts[:,i] = solveLandm(br + ent, vec(Xps[:,i]), init)
#   end
#   return lmPts
# end



# function calcIntersectVols( fgl::G, predLm::BallTreeDensity;
#                             currage=0, maxdeltaage=Inf) where G <: AbstractDFG
#     # TODO upgrade to using MMD test
#     # all landmarks of interest
#     ll = ls(fgl, r"l\d")
#     # output result
#     rr = Dict{String, RemoteRef}()
#     fetchlist = String[]
#     iv = Dict{String, Float64}()
#     for l in ll
#       pvlm = getVariable(fgl,l)
#       # TODO -- can be improved via query in DB case
#       if currage - pvlm.attributes["maxage"] < maxdeltaage
#         p = getBelief(fgl, l)
#         rr[l] = remotecall(uppA(), intersIntgAppxIS, p,predLm)
#         push!(fetchlist, l)
#       else
#         println("calcIntersectVols -- ignoring $(l) because maxdeltaage exceeded")
#         iv[l] = 0
#       end
#     end
#     max = 0
#     maxl = String("")
#     for l in fetchlist #ll
#       # p = getBelief(fgl, l)
#       # tv = intersIntgAppxIS(p,predLm)
#       # iv[l] = tv
#       tv = fetch(rr[l])
#       iv[l] = tv
#       if max < tv  max = tv; maxl = l; end
#     end
#     return iv, maxl
# end

# function maxIvWithoutID(ivs::Dict{String, Float64}, l::T) where {T <: AbstractString}
#   max = 0
#   maxl = String("")
#   for i in ivs
#     if max < i[2] && i[1] != l;  max = i[2]; maxl = i[1]; end
#   end
#   return maxl
# end

# # binary tests to distinguish how to automatically add a landmark to the existing factor graph
# function doAutoEvalTests(fgl::G, ivs::Dict{T, Float64}, maxl::T, lmid::Int, lmindx::Int) where {G <: AbstractDFG, T <: AbstractString}
#   maxAnyval = maxl != String("") ? ivs[maxl] : 0.0
#   # maxid = fgl.IDs[maxl]
#   lmidSugg = lmid != -1 # a landmark ID has been suggested
#   maxAnyExists = maxAnyval > 0.03 # there is notable intersection with previous landm
#   lmIDExists = haskey(fgl.v, lmid) # suggested lmid already in fgl
#   newlmindx = lmindx
#   if lmIDExists
#     lmSuggLbl = String(getVert(fgl,lmid).label) # TODO -- wasteful
#   else
#     newlmindx = lmindx + 1
#     lmSuggLbl = String(string('l',newlmindx))
#   end
#   maxl2 = lmIDExists ? maxIvWithoutID(ivs, lmSuggLbl) : String("")
#   maxl2Exists = lmIDExists ? (maxl2 != "" ? ivs[maxl2] > 0.03 : false) : false # there is notable intersection with previous landm
#   intgLmIDExists = lmIDExists ? ivs[lmSuggLbl] > 0.03 : false

#   return lmidSugg, maxAnyExists, maxl2Exists, maxl2, lmIDExists, intgLmIDExists, lmSuggLbl, newlmindx
# end


# function evalAutoCases!(fgl::G, lmid::Int, ivs::Dict{T, Float64}, maxl::T,
#                         pose::T, lmPts::Array{Float64,2}, br::Array{Float64,1}, cov::Array{Float64,2}, lmindx::Int;
#                         N::Int=100, solvable::Int=1 ) where {G <: AbstractDFG, T <: AbstractString}
#   lmidSugg, maxAnyExists, maxl2Exists, maxl2, lmIDExists, intgLmIDExists, lmSuggLbl, newlmindx = doAutoEvalTests(fgl,ivs,maxl,lmid, lmindx)

#   println("evalAutoCases -- found=$(lmidSugg), $(maxAnyExists), $(maxl2Exists), $(lmIDExists), $(intgLmIDExists)")

#   vlm = Union{}; fbr = Union{};
#   if (!lmidSugg && !maxAnyExists)
#     #new landmark and UniBR constraint
#     v,L,lm = getLastLandm2D(fgl)
#     vlm = newLandm!(fgl, lm, lmPts, cov, N=N,solvable=solvable)
#     fbr = addBRFG!(fgl, pose, lm, br, cov, solvable=solvable)
#   elseif !lmidSugg && maxAnyExists
#     # add UniBR to best match maxl
#     vlm = getVariable(fgl,maxl)
#     fbr = addBRFG!(fgl, pose, maxl, br, cov, solvable=solvable)
#   elseif lmidSugg && !maxl2Exists && !lmIDExists
#     #add new landmark and add UniBR to suggested lmid
#     vlm = newLandm!(fgl, lmSuggLbl, lmPts, cov, N=N, solvable=solvable)
#     fbr = addBRFG!(fgl, pose, lmSuggLbl, br, cov, solvable=solvable)
#   elseif lmidSugg && !maxl2Exists && lmIDExists && intgLmIDExists
#     # doesn't self intesect with existing lmid, add UniBR to lmid
#     vlm = getVariable(fgl, lmid)
#     fbr = addBRFG!(fgl, pose, lmSuggLbl, br, cov, solvable=solvable)
#   elseif lmidSugg && maxl2Exists && !lmIDExists
#     # add new landmark and add MMBR to both maxl and lmid
#     vlm = newLandm!(fgl, lmSuggLbl, lmPts, cov, N=N, solvable=solvable)
#     addMMBRFG!(fgl, pose, [maxl2;lmSuggLbl], br, cov, solvable=solvable)
#   elseif lmidSugg && maxl2Exists && lmIDExists && intgLmIDExists
#     # obvious case, add MMBR to both maxl and lmid. Double intersect might be the same thing
#     println("evalAutoCases! -- obvious case is happening")
#     addMMBRFG!(fgl, pose, [maxl2;lmSuggLbl], br, cov, solvable=solvable)
#     vlm = getVariable(fgl,lmSuggLbl)
#   elseif lmidSugg && maxl2Exists && lmIDExists && !intgLmIDExists
#     # odd case, does not intersect with suggestion, but does with some previous landm
#     # add MMBR
#     @warn "evalAutoCases! -- no self intersect with suggested $(lmSuggLbl) detected"
#     addMMBRFG!(fgl, pose, [maxl;lmSuggLbl], br, cov, solvable=solvable)
#     vlm = getVariable(fgl,lmSuggLbl)
#   elseif lmidSugg && !maxl2Exists && lmIDExists && !intgLmIDExists
#   #   # landm exists but no intersection with existing or suggested lmid
#   #   # may suggest some error
#     @warn "evalAutoCases! -- no intersect with suggested $(lmSuggLbl) or map detected, adding  new landmark MM constraint incase"
#     v,L,lm = getLastLandm2D(fgl)
#     vlm = newLandm!(fgl, lm, lmPts, cov, N=N, solvable=solvable)
#     addMMBRFG!(fgl, pose, [lm; lmSuggLbl], br, cov, solvable=solvable)
#   else
#     error("evalAutoCases! -- unknown case encountered, can reduce to this error to a warning and ignore user request")
#   end

#   return vlm, fbr, newlmindx
# end

# function addAutoLandmBR!(fgl::G,
#                          pose::T,
#                          lmid::Int,
#                          br::Array{Float64,1},
#                          cov::Array{Float64,2},
#                          lmindx::Int;
#                          N::Int=100,
#                          solvable::Int=1  ) where {G <: AbstractDFG, T <: AbstractString}
#   #
#   vps = getVariable(fgl, pose)
#   lmPts = projNewLandmPoints(vps, br, cov)
#   lmkde = kde!(lmPts)
#   currage = parse(Int, pose[2:end])
#   ivs, maxl = calcIntersectVols(fgl, lmkde, currage=currage,maxdeltaage=10)

#   # There are 8 cases of interest
#   vlm, fbr, newlmindx = evalAutoCases!(fgl, lmid, ivs, maxl,pose,lmPts, br,cov,lmindx,N=N,solvable=solvable)

#   return vlm, fbr, newlmindx
# end


# function newLandm!(fg::AbstractDFG, lm::T, wPos::Array{Float64,2}, sig::Array{Float64,2};
#                   N::Int=100, solvable::Int=1, labels::Vector{T}=String[]) where {T <: AbstractString}

#     vert=addVariable!(fg, Symbol(lm), Point2, N=N, solvable=solvable, tags=union(["LANDMARK";], labels))
#     # TODO -- need to confirm this function is updating the correct memory location. v should be pointing into graph
#     # vert=addVariable!(fg, Symbol(lm), wPos, sig, N=N, solvable=solvable, tags=labels)

#     vert.attributes["age"] = 0
#     vert.attributes["maxage"] = 0
#     vert.attributes["numposes"] = 0
#     updateFullVert!(fg, vert)

#     println("newLandm! -- added $(lm)")
#     return vert
# end

# function addBRFG!(fg::G,
#                   pose::T,
#                   lm::T,
#                   br::Array{Float64,1},
#                   cov::Array{Float64,2};
#                   solvable::Int=1  ) where {G <: AbstractDFG, T <: AbstractString}
#   #
#   vps = getVert(fg,pose)
#   vlm = getVert(fg,lm)
#   testlbl = vps.label*vlm.label
#   for nei in getOutNeighbors(fg, vlm)
#     if nei.label == testlbl
#       # TODO -- makes function call brittle
#       @warn "We already have $(testlbl), skipping this constraint"
#       return nothing
#     end
#   end
#   @show keys(vlm.attributes)
#   np = vlm.attributes["numposes"]
#   la = vlm.attributes["age"]
#   nage = parse(Int,pose[2:end])
#   vlm.attributes["numposes"] = np+1
#   vlm.attributes["age"] = ((la*np)+nage)/(np+1)
#   vlm.attributes["maxage"] = nage
#   updateFullVert!(fg, vlm)


#   pbr = Pose2Point2BearingRange(Normal(br[1], cov[1,1]), Normal(br[2],  cov[2,2]))  #{Normal, Normal}
#   @show vps, vlm
#   f = addFactor!(fg, [vps;vlm], pbr, solvable=solvable, graphinit=true ) #[vps;vlm],

#   # only used for max likelihood unimodal tests.
#   u, P = pol2cart(br[[2;1]], diag(cov))
#   infor = inv(P^2)
#   # addLandmMeasRemote(vps.index,vlm.index,u,infor) # for iSAM1 remote solution as reference
#   return f
# end

# function addMMBRFG!(fg::G,
#                     syms::Array{Symbol,1}, br::Array{Float64,1},
#                     cov::Array{Float64,2}; w::Vector{Float64}=Float64[0.5;0.5],
#                     solvable::Int=1) where G <: AbstractDFG
#     #
#     # vps = getVert(fg,pose)
#     # vlm1 = getVert(fg,lm[1])
#     # vlm2 = getVert(fg,lm[2])

#     pbr = Pose2Point2BearingRange(Normal(br[1],cov[1,1]),  Normal(br[2],cov[2,2]))
#     syms = Symbol.([pose;lm...])
#     f = addFactor!(fg, syms, pbr, multihypo=[1.0; w...], solvable=solvable, graphinit=true )
#     return f
# end

# function projNewLandm!(fg::G,
#                        pose::T,
#                        lm::T,
#                        br::Array{Float64,1},
#                        cov::Array{Float64,2};
#                        addfactor=true,
#                        N::Int=100,
#                        solvable::Int=1,
#                        labels::Vector{T}=String[]  ) where {G <: AbstractDFG, T <: AbstractString}
#     #
#     vps = getVariable(fg, pose)

#     lmPts = projNewLandmPoints(vps, br, cov)
#     vlm = newLandm!(fg, lm, lmPts, cov, N=N, solvable=solvable, tags=labels) # cov should not be required here
#     if addfactor
#       fbr = addBRFG!(fg, pose, lm, br, cov, solvable=solvable)
#       return vlm, fbr
#     end
#     return vlm
# end




##==============================================================================
## OLD Victory Park Example code, don't delete until replacements are coded
##==============================================================================



