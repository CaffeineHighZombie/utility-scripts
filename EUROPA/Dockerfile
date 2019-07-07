FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive
## Setting up build tools and utilities
RUN apt-get update -y
RUN apt-get install -y software-properties-common apt-utils
RUN apt-get update -y
RUN apt-get install -y build-essential g++
RUN apt-get install -y curl unzip nano
## JRE and Ant
RUN apt-get update
RUN apt-get install -y default-jre
RUN apt-get install -y default-jdk
RUN java -version
RUN javac -version
RUN apt-get install -y ant
RUN ant -version
## Python
RUN apt-get update
RUN apt-get install -y python-dev python-pip python-setuptools
RUN python --version
## libantlr3c
RUN curl -LO https://www.antlr3.org/download/C/libantlr3c-3.4.tar.gz
RUN tar xvzf libantlr3c-3.4.tar.gz
WORKDIR libantlr3c-3.4/
RUN ./configure --enable-64bit
RUN make
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf libantlr3c-3.4/
RUN rm libantlr3c-3.4.tar.gz
## SWIG and PCRE
RUN apt-get update
RUN apt-get install -y libpcre3-dev libpcre++-dev
RUN curl -LO https://nchc.dl.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz
RUN tar xzvf swig-3.0.12.tar.gz
WORKDIR swig-3.0.12/
RUN ./configure
RUN make
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf swig-3.0.12/
RUN rm swig-3.0.12.tar.gz
## Jam
RUN apt-get update
RUN apt-get install -y bison flex
RUN apt-get install -y git
RUN git clone --depth=1 https://github.com/CaffeineHighZombie/europa-pso
WORKDIR europa-pso/ThirdParty/trunk
RUN mkdir jam
RUN cp jam-2.5.zip jam/
WORKDIR /europa-pso/ThirdParty/trunk/jam
RUN unzip jam-2.5.zip 
RUN make
WORKDIR /europa-pso/ThirdParty/trunk
RUN cp -a jam /usr/share/
RUN ln -s /usr/share/jam/jam0 /usr/bin/jam
## CppUnit
RUN tar xjvf cppunit-1.12.1.tar.bz2
WORKDIR /europa-pso/ThirdParty/trunk/cppunit-1.12.1/
RUN ./configure CXX="g++ -m64" LDFLAGS="-ldl"
RUN make 
RUN make install
RUN ldconfig
WORKDIR /
RUN rm -rf /europa-pso
## cmake
RUN apt-get update
RUN apt-get install -y cmake
## Boost Libraries
RUN apt-get update
RUN apt-get install -y libboost-all-dev
## doxygen and graphviz
RUN apt-get update
RUN apt-get install -y doxygen
RUN apt-get install -y python-pydot python-pydot-ng graphviz
## Europa
RUN git clone https://github.com/nasa/europa
WORKDIR /europa
RUN mkdir build
WORKDIR /europa/build
RUN cmake ..
RUN make
RUN make install
## Recreating Directory structure and files for planner usage
## Createing directories
WORKDIR /europa
RUN mkdir ~/europa
RUN mkdir ~/europa/bin
RUN mkdir ~/europa/bin/.makeproject
RUN mkdir ~/europa/bin/.makeproject/java
RUN mkdir ~/europa/config
RUN mkdir ~/europa/examples
RUN mkdir ~/europa/include
RUN mkdir ~/europa/include/jam
RUN mkdir ~/europa/include/PLASMA
RUN mkdir ~/europa/lib

## /bin
RUN cp dist/europa/bin/autobuild ~/europa/bin/
RUN cp dist/europa/bin/autobuild-linux.sh ~/europa/bin/
RUN cp dist/europa/bin/autobuild-mingw.sh ~/europa/bin/
RUN cp dist/europa/bin/checkant.xml ~/europa/bin/
RUN cp dist/europa/bin/checkmakeproject ~/europa/bin/
RUN cp dist/europa/bin/checksvn ~/europa/bin/
RUN cp dist/europa/bin/coverage ~/europa/bin/
RUN cp dist/europa/bin/makeproject ~/europa/bin/
RUN cp dist/europa/bin/nddlcompile ~/europa/bin/
RUN cp dist/europa/bin/nddlparse ~/europa/bin/
RUN cp dist/europa/bin/plancompare ~/europa/bin/
RUN cp dist/europa/bin/runExample.bat ~/europa/bin/
RUN cp -r dist/europa/bin/.makeproject/ ~/europa/bin/

## /config
RUN cp dist/europa/config/Debug.cfg ~/europa/config/
RUN cp dist/europa/config/NDDL.cfg ~/europa/config/
RUN cp dist/europa/config/PlannerConfig.xml ~/europa/config/

## /include/jam
RUN cp src/PLASMA/Antlr3Rules ~/europa/include/jam/
RUN cp src/PLASMA/CommonRules ~/europa/include/jam/
RUN cp src/PLASMA/JavaRules ~/europa/include/jam/
RUN cp src/PLASMA/ModuleRules ~/europa/include/jam/
RUN cp src/PLASMA/NddlRules ~/europa/include/jam/
RUN cp src/PLASMA/PlatformRules ~/europa/include/jam/
RUN cp src/PLASMA/SWIGRules ~/europa/include/jam/
RUN cp src/PLASMA/VariantRules ~/europa/include/jam/

## /include/PLASMA
RUN cp dist/europa/ANML/component/AnmlInterpreter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ANML/component/AnmlTestEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ANML/base/ANMLTranslator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/CESchema.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/CFunction.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/CFunctions.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/ClosedWorldFVDetector.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/CommonAncestorConstraint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/CommonDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/ComponentFactory.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/ConstrainedVariable.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/Constraint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/ConstraintEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/ConstraintEngineDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/ConstraintEngineListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/Constraints.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/ConstraintType.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/Context.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/DataType.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/DataTypes.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/Db.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/DbClient.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/DbClientListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/DbClientTransactionLog.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/DbClientTransactionPlayer.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Debug.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/DebugMsg.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/DefaultTemporalAdvisor.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/base/DistanceGraph.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/Domain.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/DomainListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/Domains.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/DurativeTokens.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Edge.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/EdgeIterator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Engine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Entity.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/EntityIterator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/EquivalenceClassCollection.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Error.hh ~/europa/include/PLASMA/
RUN cp dist/europa/System/base/EuropaEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/EuropaLogger.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/EuropaLoggerMacros.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/EventToken.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Factory.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/Filters.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/FlawFilter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/FlawHandler.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/FlawManager.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/FlowProfile.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/GenericFVDetector.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Graph.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/GroundedFVDetector.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/GroundedProfile.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/HasAncestorConstraint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/HashPriorityQueue.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/HSTSDecisionPoints.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Id.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/IdTable.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/IncrementalFlowProfile.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/Instant.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/InstantTokens.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/component/Interpreter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/NDDL/InterpreterResources.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/IntervalToken.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/LabelStr.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Logger.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/LoggerInterface.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Logger-log4cpp.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/LoggerMgr.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/MatchingEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/MatchingRule.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/MaxFlow.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/MergeMemento.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/Method.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/Methods.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Module.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ANML/ModuleAnml.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/ModuleConstraintEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/ModuleNddl.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/ModulePlanDatabase.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/ModuleResource.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/ModuleRulesEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/ModuleSolvers.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/ModuleTemporalNetwork.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Mutex.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/base/Nddl.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/NddlDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/component/NddlInterpreter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/NDDL/NddlResource.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/base/NddlRules.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/component/NddlTestEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/base/NddlToken.hh ~/europa/include/PLASMA/
RUN cp dist/europa/NDDL/base/NddlUtils.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Node.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/NodeIterator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/Number.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/Object.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/ObjectTokenRelation.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/ObjectType.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/OpenConditionDecisionPoint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/OpenConditionManager.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/OpenWorldFVDetector.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PDBInterpreter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Pdlfcn.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PlanDatabase.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/PlanDatabaseDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PlanDatabaseListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PlanDatabaseWriter.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/Profile.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/ProfilePropagator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/Propagator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/Propagators.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/ProxyVariableRelation.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/PSConstraintEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/PSConstraintEngineListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/System/base/PSEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/System/base/PSEngineImpl.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PSPlanDatabase.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/PSPlanDatabaseListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/PSResource.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/PSSolvers.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/PSSolversImpl.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/PSVarValue.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Reservoir.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/Resource.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/ResourceDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Solvers/ResourceMatching.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Solvers/ResourceThreatDecisionPoint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Solvers/ResourceThreatManager.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/ResourceTokenRelation.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Reusable.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/Rule.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/RuleInstance.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/RulesEngine.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/RulesEngineDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/RulesEngineListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/RulesEngine/base/RuleVariableListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/Schema.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/SearchListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/Solver.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/SolverDecisionPoint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/SolverDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/base/SolverUtils.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/StackMemento.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/component/STNTemporalAdvisor.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/StringErrorStream.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/TemporalAdvisor.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/base/TemporalNetwork.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/TemporalNetworkDefs.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/component/TemporalNetworkListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/component/TemporalPropagator.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/test/TestData.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/ThreatDecisionPoint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/ThreatManager.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/component/Timeline.hh ~/europa/include/PLASMA/
RUN cp dist/europa/TemporalNetwork/component/TimepointWrapper.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/TimetableProfile.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/base/Transaction.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Resource/component/Types.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/UnboundVariableDecisionPoint.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/UnboundVariableManager.hh ~/europa/include/PLASMA/
RUN cp dist/europa/PlanDatabase/base/UnifyMemento.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/Utils.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Solvers/component/ValueSource.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/component/Variable.hh ~/europa/include/PLASMA/
RUN cp dist/europa/ConstraintEngine/base/VariableChangeListener.hh ~/europa/include/PLASMA/
RUN cp dist/europa/Utils/base/XMLUtils.hh ~/europa/include/PLASMA/

## /include
RUN cp dist/europa/ConstraintEngine/base/PSConstraintEngine.hh ~/europa/include/
RUN cp dist/europa/ConstraintEngine/base/PSConstraintEngineListener.hh ~/europa/include/
RUN cp dist/europa/System/base/PSEngine.hh ~/europa/include/
RUN cp dist/europa/PlanDatabase/base/PSPlanDatabase.hh ~/europa/include/
RUN cp dist/europa/PlanDatabase/base/PSPlanDatabaseListener.hh ~/europa/include/
RUN cp dist/europa/Resource/base/PSResource.hh ~/europa/include/
RUN cp dist/europa/Solvers/PSSolvers.hh ~/europa/include/
RUN cp dist/europa/ConstraintEngine/base/PSVarValue.hh ~/europa/include/
RUN cp dist/europa/Utils/base/PSEntity.hh ~/europa/include/
RUN cp dist/europa/Utils/base/PSList.hh ~/europa/include/

## /lib
RUN cp dist/europa/libANML_g.so ~/europa/lib/
RUN cp dist/europa/libConstraintEngine_g.so ~/europa/lib/
RUN cp dist/europa/libNDDL_g.so ~/europa/lib/
RUN cp dist/europa/libPlanDatabase_g.so ~/europa/lib/
RUN cp dist/europa/libPSEngine_g.so ~/europa/lib/
RUN cp dist/europa/libResource_g.so ~/europa/lib/
RUN cp dist/europa/libRulesEngine_g.so ~/europa/lib/
RUN cp dist/europa/libSolvers_g.so ~/europa/lib/
RUN cp dist/europa/libSystem_g.so ~/europa/lib/
RUN cp dist/europa/libTemporalNetwork_g.so ~/europa/lib/
RUN cp dist/europa/libTinyXml_g.so ~/europa/lib/
RUN cp dist/europa/libUtils_g.so ~/europa/lib/
RUN cp dist/europa/PSEngine.jar ~/europa/lib/
RUN cp dist/europa/PSUISwing.jar ~/europa/lib/

## example
RUN cp -r examples/* ~/europa/examples/
RUN echo '#!/bin/bash' >> ~/europa/export.bash
RUN echo 'export EUROPA_HOME=~/europa' >> ~/europa/export.bash
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EUROPA_HOME/lib' >> ~/europa/export.bash
RUN echo 'export DYLD_BIND_AT_LAUNCH=YES' >> ~/europa/export.bash
RUN echo 'export ANT_HOME=/usr/share/ant' >> ~/europa/export.bash
RUN echo 'export PATH=${ANT_HOME}/bin:${PATH}' >> ~/europa/export.bash
RUN echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/europa/export.bash
RUN echo source ~/europa/export.bash >> ~/.bashrc
## Dockerfile build done
