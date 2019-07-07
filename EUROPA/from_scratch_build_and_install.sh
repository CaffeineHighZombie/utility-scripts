#!/bin/bash

## Setting up build tools and utilities
sudo apt-get update
sudo apt-get install -y software-properties-common apt-utils
sudo apt-get update
sudo apt-get install -y build-essential g++
sudo apt-get install -y curl unzip

## JRE and Ant
sudo apt-get update
sudo apt-get install -y default-jre
sudo apt-get install -y default-jdk
java -version
javac -version
sudo apt-get install -y ant
ant -version

## Python
sudo apt-get update
sudo apt-get install -y python-dev python-pip python-setuptools
python --version

## libantlr3c
curl -LO https://www.antlr3.org/download/C/libantlr3c-3.4.tar.gz
tar xvzf libantlr3c-3.4.tar.gz
pushd libantlr3c-3.4/
./configure --enable-64bit
make
sudo make install
sudo ldconfig
popd
rm -rf libantlr3c-3.4/
rm libantlr3c-3.4.tar.gz

## SWIG and PCRE
sudo apt-get update
sudo apt-get install -y libpcre3-dev libpcre++-dev
curl -LO https://nchc.dl.sourceforge.net/project/swig/swig/swig-3.0.12/swig-3.0.12.tar.gz
tar xzvf swig-3.0.12.tar.gz
pushd swig-3.0.12/
./configure
make
sudo make install
sudo ldconfig
popd
rm -rf swig-3.0.12/
rm swig-3.0.12.tar.gz

## Jam
sudo apt-get update
sudo apt-get install -y bison flex git
git clone --depth=1 https://github.com/CaffeineHighZombie/europa-pso
pushd europa-pso/ThirdParty/trunk/
mkdir jam
cp jam-2.5.zip jam/
pushd jam
unzip jam-2.5.zip 
make
popd
sudo cp -a jam /usr/share/
sudo ln -s /usr/share/jam/jam0 /usr/bin/jam

## CppUnit
tar xjvf cppunit-1.12.1.tar.bz2
pushd cppunit-1.12.1/
./configure CXX="g++ -m64" LDFLAGS="-ldl"
make 
sudo make install
sudo ldconfig
popd
popd
rm -rf /europa-pso

## cmake
sudo apt-get update
sudo apt-get install -y cmake

## Boost Libraries
sudo apt-get update
sudo apt-get install -y libboost-all-dev

## doxygen and graphviz
sudo apt-get update
sudo apt-get install -y doxygen
sudo apt-get install -y python-pydot python-pydot-ng graphviz

## Europa
git clone https://github.com/nasa/europa
pushd europa
mkdir build
pushd build
cmake ..
## When building for TREX2 agent comment the line above (93) and uncomment the line below (95)
#cmake -DOPTIMIZE=1 -DCOVERAGE=0 ..
make
make install
popd


## Recreating Directory structure and files for planner usage
## Creating directories
mkdir ~/europa
mkdir ~/europa/bin
mkdir ~/europa/bin/.makeproject
mkdir ~/europa/bin/.makeproject/java
mkdir ~/europa/config
mkdir ~/europa/examples
mkdir ~/europa/include
mkdir ~/europa/include/jam
mkdir ~/europa/include/PLASMA
mkdir ~/europa/lib

## /bin
cp dist/europa/bin/autobuild ~/europa/bin/
cp dist/europa/bin/autobuild-linux.sh ~/europa/bin/
cp dist/europa/bin/autobuild-mingw.sh ~/europa/bin/
cp dist/europa/bin/checkant.xml ~/europa/bin/
cp dist/europa/bin/checkmakeproject ~/europa/bin/
cp dist/europa/bin/checksvn ~/europa/bin/
cp dist/europa/bin/coverage ~/europa/bin/
cp dist/europa/bin/makeproject ~/europa/bin/
cp dist/europa/bin/nddlcompile ~/europa/bin/
cp dist/europa/bin/nddlparse ~/europa/bin/
cp dist/europa/bin/plancompare ~/europa/bin/
cp dist/europa/bin/runExample.bat ~/europa/bin/
cp -r dist/europa/bin/.makeproject/ ~/europa/bin/

## /config
cp dist/europa/config/Debug.cfg ~/europa/config/
cp dist/europa/config/NDDL.cfg ~/europa/config/
cp dist/europa/config/PlannerConfig.xml ~/europa/config/

## /include/jam
cp src/PLASMA/Antlr3Rules ~/europa/include/jam/
cp src/PLASMA/CommonRules ~/europa/include/jam/
cp src/PLASMA/JavaRules ~/europa/include/jam/
cp src/PLASMA/ModuleRules ~/europa/include/jam/
cp src/PLASMA/NddlRules ~/europa/include/jam/
cp src/PLASMA/PlatformRules ~/europa/include/jam/
cp src/PLASMA/SWIGRules ~/europa/include/jam/
cp src/PLASMA/VariantRules ~/europa/include/jam/

## /include/PLASMA
cp dist/europa/ANML/component/AnmlInterpreter.hh ~/europa/include/PLASMA/
cp dist/europa/ANML/component/AnmlTestEngine.hh ~/europa/include/PLASMA/
cp dist/europa/ANML/base/ANMLTranslator.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/CESchema.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/CFunction.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/CFunctions.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/ClosedWorldFVDetector.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/CommonAncestorConstraint.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/CommonDefs.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/ComponentFactory.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/ConstrainedVariable.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/Constraint.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/ConstraintEngine.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/ConstraintEngineDefs.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/ConstraintEngineListener.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/Constraints.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/ConstraintType.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/Context.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/DataType.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/DataTypes.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/Db.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/DbClient.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/DbClientListener.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/DbClientTransactionLog.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/DbClientTransactionPlayer.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Debug.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/DebugMsg.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/DefaultTemporalAdvisor.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/base/DistanceGraph.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/Domain.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/DomainListener.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/Domains.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/DurativeTokens.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Edge.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/EdgeIterator.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Engine.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Entity.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/EntityIterator.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/EquivalenceClassCollection.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Error.hh ~/europa/include/PLASMA/
cp dist/europa/System/base/EuropaEngine.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/EuropaLogger.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/EuropaLoggerMacros.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/EventToken.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Factory.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/Filters.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/FlawFilter.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/FlawHandler.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/FlawManager.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/FlowProfile.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/GenericFVDetector.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Graph.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/GroundedFVDetector.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/GroundedProfile.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/HasAncestorConstraint.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/HashPriorityQueue.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/HSTSDecisionPoints.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Id.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/IdTable.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/IncrementalFlowProfile.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/Instant.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/InstantTokens.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/component/Interpreter.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/NDDL/InterpreterResources.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/IntervalToken.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/LabelStr.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Logger.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/LoggerInterface.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Logger-log4cpp.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/LoggerMgr.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/MatchingEngine.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/MatchingRule.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/MaxFlow.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/MergeMemento.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/Method.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/Methods.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Module.hh ~/europa/include/PLASMA/
cp dist/europa/ANML/ModuleAnml.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/ModuleConstraintEngine.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/ModuleNddl.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/ModulePlanDatabase.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/ModuleResource.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/ModuleRulesEngine.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/ModuleSolvers.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/ModuleTemporalNetwork.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Mutex.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/base/Nddl.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/NddlDefs.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/component/NddlInterpreter.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/NDDL/NddlResource.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/base/NddlRules.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/component/NddlTestEngine.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/base/NddlToken.hh ~/europa/include/PLASMA/
cp dist/europa/NDDL/base/NddlUtils.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Node.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/NodeIterator.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/Number.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/Object.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/ObjectTokenRelation.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/ObjectType.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/OpenConditionDecisionPoint.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/OpenConditionManager.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/OpenWorldFVDetector.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PDBInterpreter.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Pdlfcn.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PlanDatabase.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/PlanDatabaseDefs.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PlanDatabaseListener.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PlanDatabaseWriter.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/Profile.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/ProfilePropagator.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/Propagator.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/Propagators.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/ProxyVariableRelation.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/PSConstraintEngine.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/PSConstraintEngineListener.hh ~/europa/include/PLASMA/
cp dist/europa/System/base/PSEngine.hh ~/europa/include/PLASMA/
cp dist/europa/System/base/PSEngineImpl.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PSPlanDatabase.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/PSPlanDatabaseListener.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/PSResource.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/PSSolvers.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/PSSolversImpl.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/PSVarValue.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Reservoir.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/Resource.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/ResourceDefs.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Solvers/ResourceMatching.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Solvers/ResourceThreatDecisionPoint.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Solvers/ResourceThreatManager.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/ResourceTokenRelation.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Reusable.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/Rule.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/RuleInstance.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/RulesEngine.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/RulesEngineDefs.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/RulesEngineListener.hh ~/europa/include/PLASMA/
cp dist/europa/RulesEngine/base/RuleVariableListener.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/Schema.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/SearchListener.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/Solver.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/SolverDecisionPoint.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/SolverDefs.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/base/SolverUtils.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/StackMemento.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/component/STNTemporalAdvisor.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/StringErrorStream.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/TemporalAdvisor.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/base/TemporalNetwork.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/TemporalNetworkDefs.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/component/TemporalNetworkListener.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/component/TemporalPropagator.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/test/TestData.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/ThreatDecisionPoint.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/ThreatManager.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/component/Timeline.hh ~/europa/include/PLASMA/
cp dist/europa/TemporalNetwork/component/TimepointWrapper.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/TimetableProfile.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/base/Transaction.hh ~/europa/include/PLASMA/
cp dist/europa/Resource/component/Types.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/UnboundVariableDecisionPoint.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/UnboundVariableManager.hh ~/europa/include/PLASMA/
cp dist/europa/PlanDatabase/base/UnifyMemento.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/Utils.hh ~/europa/include/PLASMA/
cp dist/europa/Solvers/component/ValueSource.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/component/Variable.hh ~/europa/include/PLASMA/
cp dist/europa/ConstraintEngine/base/VariableChangeListener.hh ~/europa/include/PLASMA/
cp dist/europa/Utils/base/XMLUtils.hh ~/europa/include/PLASMA/

## /include
cp dist/europa/ConstraintEngine/base/PSConstraintEngine.hh ~/europa/include/
cp dist/europa/ConstraintEngine/base/PSConstraintEngineListener.hh ~/europa/include/
cp dist/europa/System/base/PSEngine.hh ~/europa/include/
cp dist/europa/PlanDatabase/base/PSPlanDatabase.hh ~/europa/include/
cp dist/europa/PlanDatabase/base/PSPlanDatabaseListener.hh ~/europa/include/
cp dist/europa/Resource/base/PSResource.hh ~/europa/include/
cp dist/europa/Solvers/PSSolvers.hh ~/europa/include/
cp dist/europa/ConstraintEngine/base/PSVarValue.hh ~/europa/include/
cp dist/europa/Utils/base/PSEntity.hh ~/europa/include/
cp dist/europa/Utils/base/PSList.hh ~/europa/include/

## /lib
cp dist/europa/libANML_g.so ~/europa/lib/
cp dist/europa/libConstraintEngine_g.so ~/europa/lib/
cp dist/europa/libNDDL_g.so ~/europa/lib/
cp dist/europa/libPlanDatabase_g.so ~/europa/lib/
cp dist/europa/libPSEngine_g.so ~/europa/lib/
cp dist/europa/libResource_g.so ~/europa/lib/
cp dist/europa/libRulesEngine_g.so ~/europa/lib/
cp dist/europa/libSolvers_g.so ~/europa/lib/
cp dist/europa/libSystem_g.so ~/europa/lib/
cp dist/europa/libTemporalNetwork_g.so ~/europa/lib/
cp dist/europa/libTinyXml_g.so ~/europa/lib/
cp dist/europa/libUtils_g.so ~/europa/lib/
cp dist/europa/PSEngine.jar ~/europa/lib/
cp dist/europa/PSUISwing.jar ~/europa/lib/

## example
cp -r examples/* ~/europa/examples/

echo '#!/bin/bash' >> ~/europa/export.bash
echo 'export EUROPA_HOME=~/europa' >> ~/europa/export.bash
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$EUROPA_HOME/lib' >> ~/europa/export.bash
echo 'export DYLD_BIND_AT_LAUNCH=YES' >> ~/europa/export.bash
echo 'export ANT_HOME=/usr/share/ant' >> ~/europa/export.bash
echo 'export PATH=${ANT_HOME}/bin:${PATH}' >> ~/europa/export.bash
echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64' >> ~/europa/export.bash
echo source ~/europa/export.bash >> ~/.bashrc
