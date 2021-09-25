# RoME.jl

| Stable | Dev | Coverage | Docs |
|--------|-----|----------|------|
| [![version][rjl-stable]][rjl-releases] | [![CI][rjl-ci-img]][rjl-ci-url] | [![codecov.io][rjl-cov-img]][rjl-cov-url] | [![docs][docs-shield]][caesar-docs] <br> [![][caesar-slack-badge]][caesar-slack] |


## Introduction

Robot Motion Estimate (RoME.jl) is part of the overall [Caesar.jl](https://www.github.com/JuliaRobotics/Caesar.jl) and provides a set of graph variables, factors, and utility features for robotics-related navigation, tracking, and mapping (i.e. SLAM).  RoME.jl helps build front-ends using the [Multi-modal iSAM] backend solver which is implemented over at [IncrementalInference.jl](https://github.com/JuliaRobotics/IncrementalInference.jl).  See [the related references of interest here](http://www.juliarobotics.org/Caesar.jl/latest/refs/literature/).  Most notably, this package provides common navigation-type variables and factors to be included in more general [DistributedFactorGraphs.jl](https://github.com/JuliaRobotics/DistributedFactorGraphs.jl) graph objects.

[NavAbility.io](http://www.navability.io) helps the with administration and support of the Caesar.jl community, please reach out for any additional information (info@navability.io) or via the caesarjl Slack badge-link above.
## Installation

You can directly install with:

```julia
using Pkg
Pkg.add("RoME")
```

If you are interested in a broader toolkit, which includes a visualizer and database interaction, please see [Caesar.jl](https://github.com/dehann/Caesar.jl).

## Consider Citing

Consider citing our work using the common reference at [Caesar.jl Citation with IncrementalInference.jl DOI](https://github.com/JuliaRobotics/Caesar.jl#contributors).  We are grateful for many, many contributions within the Julia package ecosystem -- see the [Juliahub.com](https://juliahub.com/ui/Packages/RoME/VVxXB) page for dependencies.

## Examples

[![docs][docs-shield]][caesar-docs]
See project wide Caesar.jl documentation for more details (click on badge).

<a href="https://vimeo.com/190052649" target="_blank"><img src="https://raw.githubusercontent.com/JuliaRobotics/IncrementalInference.jl/master/doc/images/mmisamvid01.gif" alt="IMAGE ALT TEXT HERE" width="480" border="10" /></a>

## Comments and Issues Welcome

Please don't hesitate to open issues or suggestions in line with [JuliaRobotics code of conduct](https://github.com/JuliaRobotics/administration/blob/master/code_of_conduct.md).  Find [the Gist here](https://gist.github.com/dehann/5f943d833f5fb06f4e00a2f4fb9f945a).


[rjl-url]: http://www.github.com/JuliaRobotics/RoME.jl
[rjl-cov-img]: https://codecov.io/github/JuliaRobotics/RoME.jl/coverage.svg?branch=master
[rjl-cov-url]: https://codecov.io/github/JuliaRobotics/RoME.jl?branch=master
[rjl-ci-img]: https://github.com/JuliaRobotics/RoME.jl/actions/workflows/ci.yml/badge.svg
[rjl-ci-url]: https://github.com/JuliaRobotics/RoME.jl/actions/workflows/ci.yml
[rjl-stable]: https://juliahub.com/docs/RoME/version.svg
[rjl-milestones]: https://github.com/JuliaRobotics/RoME.jl/milestones
[rjl-releases]: https://github.com/JuliaRobotics/RoME.jl/releases
[rjl-juliahub]: https://juliahub.com/ui/Packages/RoME/VVxXB


[docs-shield]: https://img.shields.io/badge/docs-latest-blue.svg
[caesar-docs]: http://juliarobotics.github.io/Caesar.jl/latest/
[caesar-slack-badge]: https://img.shields.io/badge/Caesarjl-Slack-green.svg?style=popout
[caesar-slack]: https://join.slack.com/t/caesarjl/shared_invite/zt-ucs06bwg-y2tEbddwX1vR18MASnOLsw
