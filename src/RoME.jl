module RoME

using Reexport

@reexport using IncrementalInference
@reexport using TransformUtils
@reexport using Distributions
@reexport using KernelDensityEstimate
@reexport using ApproxManifoldProducts

using
  Dates,
  FileIO,
  Distributed,
  LinearAlgebra,
  Statistics,
  Rotations,
  CoordinateTransformations,
  JLD2,
  ProgressMeter,
  DocStringExtensions,
  DistributedFactorGraphs,
  TensorCast,
  ManifoldsBase

using StaticArrays

# to avoid name conflicts
import Manifolds
using Manifolds: hat, ProductGroup, ProductManifold, SpecialEuclidean, ProductRepr, SpecialOrthogonal, TranslationGroup, identity_element

import Manifolds: project, project!

export SpecialOrthogonal, SpecialEuclidean

# using Graphs,  # TODO determine how many parts still require Graphs still directly


import Base: +, \, convert
import TransformUtils: ⊖, ⊕, convert, ominus, veeQuaternion
import IncrementalInference: MB
import IncrementalInference: convert, getSample, reshapeVec2Mat, DFG
# not sure why this is gives import error
import DistributedFactorGraphs: compare
import DistributedFactorGraphs: getDimension, getManifold

# const AMP = ApproxManifoldProducts

const InstanceType{T} = Union{Type{<:T},T}

# export the API
include("ExportAPI.jl")


# load the source files
include("SpecialDefinitions.jl")

#uses DFG v0.10.2 @defVariable for above
include("variables/Local_Manifold_Workaround.jl")
include("variables/VariableTypes.jl")

## More factor types
# RoME internal factors (FYI outside factors are easy, see Caesar documentation)
include("factors/Point2D.jl")
include("factors/Range2D.jl")
include("factors/Bearing2D.jl")
include("factors/BearingRange2D.jl")
include("factors/Polar.jl")
include("factors/PriorPose2.jl")
include("factors/PartialPriorPose2.jl")
include("factors/Pose2D.jl")
include("factors/Pose2Point2.jl")
include("factors/MutablePose2Pose2.jl")
include("factors/DynPoint2D.jl")
include("factors/VelPoint2D.jl")
include("factors/DynPose2D.jl")
include("factors/VelPose2D.jl")
include("factors/Point3D.jl")
include("factors/Point3Point3.jl")
include("factors/Pose3D.jl")
include("factors/Pose3Pose3.jl")
include("factors/PartialPose3.jl")
include("factors/MultipleFeaturesConstraint.jl")
include("factors/InertialPose3.jl")

# tools that come and go
include("TemporaryFunctionality.jl")

# additional tools
include("FactorGraphAnalysisTools.jl")

# tools related to robotics
include("BayesTracker.jl")
include("SensorModels.jl")
include("CameraModel.jl")
include("Slam.jl")
include("RobotUtils.jl")
include("SimulationUtils.jl")
include("OdometryUtils.jl")
include("RobotDataTypes.jl")
include("NavigationSystem.jl")

# generate canonical graphs
include("canonical/GenerateCommon.jl")
include("canonical/GenerateCircular.jl")
include("canonical/GenerateBox.jl")
include("canonical/GenerateHexagonal.jl")
include("canonical/GenerateHoneycomb.jl")
include("canonical/GenerateBeehive.jl")
include("canonical/GenerateHelix.jl")

# more utils requiring earlier functions
include("AdditionalUtils.jl")
include("g2oParser.jl")

# ScalarFields
include("services/ScalarFields.jl")

# things on their way out
include("Deprecated.jl")

# optional tools
using Requires

function __init__()
  # combining neural networks natively into the non-Gaussian  factor graph object
  @require Flux="587475ba-b771-5e3f-ad9e-33799f191a9c" begin
    @info "Loading RoME.jl tools related to Flux.jl."
    include("factors/flux/models/Pose2OdoNN_01.jl") # until a better way is found to deserialize
    include("factors/flux/MixtureFluxPose2Pose2.jl")
  end

  # Scalar field specifics
  
  @require ImageCore = "a09fc81d-aa75-5fe9-8630-4744c3626534" begin
    @require ImageIO = "82e4d734-157c-48bb-816b-45c225c6df19" include("services/RequiresImages.jl")
  end
  # Images="916415d5-f1e6-5110-898d-aaa5f9f070e0" 

  # @require Interpolations="a98d9a8b-a2ab-59e6-89dd-64a1c18fca59" begin 
  #   include("services/ScalarFieldsInterpolations.jl")
  # end
end

# manifold conversions required during transformation



end
