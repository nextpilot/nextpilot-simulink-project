function cs = nextpilot_project_gencode_config()
% 在 15-Sep-2025 11:25:21 上生成的配置集的 MATLAB 函数
% MATLAB 版本: 24.2.0.2712019 (R2024b)

cs = Simulink.ConfigSet;

% 原始配置集版本: 24.1.0
if cs.versionCompare('24.1.0') < 0
    error('Simulink:MFileVersionViolation', '目标配置集的版本早于原始配置集。');
end

% 字符编码: UTF-8

% 不要更改以下命令的顺序。参数之间存在依存关系。
cs.set_param('Name', 'SDOFS_GENCODE'); % 名称
cs.set_param('Description', ''); % 描述

% Original configuration set target is grt.tlc
cs.switchTarget('grt.tlc','');

cs.set_param('HardwareBoard', 'None');   % Hardware board

cs.set_param('TargetLang', 'C++');   % 语言

cs.set_param('CodeInterfacePackaging', 'C++ class');   % 代码接口打包

cs.set_param('GenerateAllocFcn', 'off');   % 使用动态内存分配进行模型初始化

cs.set_param('Solver', 'FixedStepAuto');   % 求解器

% Solver
cs.set_param('StartTime', '0');   % 开始时间
cs.set_param('StopTime', '200');   % 停止时间
cs.set_param('SolverName', 'FixedStepAuto');   % 求解器
cs.set_param('SolverType', 'Fixed-step');   % 类型
cs.set_param('SampleTimeConstraint', 'Unconstrained');   % 周期性采样时间约束
cs.set_param('FixedStep', '5/1000');   % 定步长(基础采样时间)
cs.set_param('EnableFixedStepZeroCrossing', 'off');   % 为定步长仿真启用过零检测
cs.set_param('ConcurrentTasks', 'off');   % 允许任务在目标上并发执行
cs.set_param('EnableMultiTasking', 'off');   % 将每个离散速率视为单独任务
cs.set_param('AllowMultiTaskInputOutput', 'off');   % 允许多个任务访问输入和输出
cs.set_param('PositivePriorityOrder', 'off');   % 优先级值越高，任务优先级越高
cs.set_param('AutoInsertRateTranBlk', 'off');   % 自动处理数据传输的速率转换

% Data Import/Export
cs.set_param('Decimation', '1');   % 抽取
cs.set_param('LoadExternalInput', 'off');   % 加载外部输入
cs.set_param('SaveFinalState', 'off');   % 保存最终状态
cs.set_param('LoadInitialState', 'off');   % 加载初始状态
cs.set_param('LimitDataPoints', 'off');   % 限制数据点
cs.set_param('SaveFormat', 'Dataset');   % 格式
cs.set_param('SaveOutput', 'on');   % 保存输出
cs.set_param('SaveState', 'off');   % 保存状态
cs.set_param('SignalLogging', 'on');   % 信号记录
cs.set_param('DSMLogging', 'on');   % 数据存储
cs.set_param('StreamToWks', 'on');   % 流式传输 To Workspace 模块
cs.set_param('InspectSignalLogs', 'off');   % 在仿真数据检查器中记录所记录的工作区数据
cs.set_param('SaveTime', 'on');   % 保存时间
cs.set_param('ReturnWorkspaceOutputs', 'on');   % 单一仿真输出
cs.set_param('TimeSaveName', 'tout');   % 时间变量
cs.set_param('OutputSaveName', 'yout');   % 输出变量
cs.set_param('SignalLoggingName', 'logsout');   % 信号记录名称
cs.set_param('DSMLoggingName', 'dsmout');   % 数据存储记录名称
cs.set_param('ReturnWorkspaceOutputsName', 'out');   % 仿真输出变量
cs.set_param('LoggingToFile', 'off');   % 将数据集数据记录到文件
cs.set_param('DatasetSignalFormat', 'timeseries');   % 数据集信号格式
cs.set_param('LoggingIntervals', '[-inf, inf]');   % 记录间隔

% Optimization
cs.set_param('BlockReduction', 'off');   % 模块简化
cs.set_param('BooleanDataType', 'on');   % 将逻辑信号实现为布尔数据(而不是双精度数据)
cs.set_param('ConditionallyExecuteInputs', 'on');   % 条件输入分支执行
cs.set_param('DefaultParameterBehavior', 'Tunable');   % 默认参数行为
cs.set_param('UseDivisionForNetSlopeComputation', 'off');   % 使用除法进行定点净斜率计算
cs.set_param('GainParamInheritBuiltInType', 'off');   % 增益参数继承无损的内置整数类型
cs.set_param('UseFloatMulNetSlope', 'off');   % 使用浮点乘法处理净斜率校正
cs.set_param('InheritOutputTypeSmallerThanSingle', 'off');   % 继承小于单精度的浮点输出类型
cs.set_param('DefaultUnderspecifiedDataType', 'double');   % 数据类型未定时默认使用的类型
cs.set_param('DataBitsets', 'off');   % 使用位集存储布尔数据
cs.set_param('StateBitsets', 'off');   % 使用位集存储状态配置
cs.set_param('LocalBlockOutputs', 'on');   % 启用局部模块输出
cs.set_param('EnableMemcpy', 'on');   % 使用 memcpy 进行向量赋值
cs.set_param('OptimizeBlockIOStorage', 'on');   % 信号存储重用
cs.set_param('ExpressionFolding', 'on');   % 消除多余的局部变量(表达式折叠)
cs.set_param('BufferReuse', 'on');   % 重用局部模块输出
cs.set_param('MemcpyThreshold', 64);   % Memcpy 阈值(字节)
cs.set_param('RollThreshold', 5);   % 循环展开阈值
cs.set_param('ActiveStateOutputEnumStorageType', 'Native Integer');   % 自动创建的枚举的基本存储类型
cs.set_param('InitFltsAndDblsToZero', 'off');   % 使用 memset 将浮点数和双精度值初始化为 0.0
cs.set_param('EfficientFloat2IntCast', 'off');   % 删除从浮点到整数转换中将超出范围值绕回的代码
cs.set_param('EfficientMapNaN2IntZero', 'on');   % 删除涉及饱和处理的从浮点到整数转换中将 NaN 映射至零的代码
cs.set_param('LifeSpan', 'auto');   % 应用程序生命周期(天)
cs.set_param('ClockResolution', '-1');   % 时钟分辨率(秒，-1 表示继承)
cs.set_param('MaxStackSize', 'Inherit from target');   % 最大堆栈大小(字节)
cs.set_param('BufferReusableBoundary', 'on');   % 可重用子系统的缓冲区
cs.set_param('SimCompilerOptimization', 'off');   % 编译器优化级别
cs.set_param('AccelVerboseBuild', 'off');   % 详尽的加速编译
cs.set_param('UseRowMajorAlgorithm', 'off');   % 使用针对行优先数组布局优化的算法
cs.set_param('DenormalBehavior', 'GradualUnderflow');   % 在加速仿真模式下，可以使用 '下溢为零' 选项将非正规数下溢为零。

% Diagnostics
cs.set_param('RTPrefix', 'error');   % 标识符的 "rt" 前缀
cs.set_param('ConsistencyChecking', 'none');   % 求解器数据不一致
cs.set_param('ArrayBoundsChecking', 'none');   % 超出数组边界
cs.set_param('SignalInfNanChecking', 'none');   % 模块输出为 Inf 或 NaN
cs.set_param('StringTruncationChecking', 'error');   % 字符串截断检查
cs.set_param('SignalRangeChecking', 'none');   % 仿真范围检查
cs.set_param('ReadBeforeWriteMsg', 'UseLocalSettings');   % 检测写前读
cs.set_param('WriteAfterWriteMsg', 'UseLocalSettings');   % 检测写后写
cs.set_param('WriteAfterReadMsg', 'UseLocalSettings');   % 检测读后写
cs.set_param('AlgebraicLoopMsg', 'none');   % 代数环
cs.set_param('ArtificialAlgebraicLoopMsg', 'warning');   % 尽量减少出现人为代数环
cs.set_param('SaveWithDisabledLinksMsg', 'warning');   % 模块图包含禁用的库链接
cs.set_param('SaveWithParameterizedLinksMsg', 'warning');   % 模块图包含参数化库链接
cs.set_param('UnderspecifiedInitializationDetection', 'Simplified');   % 欠定初始化检测
cs.set_param('MergeDetectMultiDrivingBlocksExec', 'error');   % 检测在同一时间步执行的多个驱动模块
cs.set_param('SignalResolutionControl', 'UseLocalSettings');   % 信号解析
cs.set_param('BlockPriorityViolationMsg', 'warning');   % 模块优先级违规
cs.set_param('TimeAdjustmentMsg', 'none');   % 采样命中时间调整
cs.set_param('SolverPrmCheckMsg', 'none');   % 自动求解器参数选择
cs.set_param('InheritedTsInSrcMsg', 'warning');   % 信号源模块指定 -1 采样时间
cs.set_param('MultiTaskDSMMsg', 'error');   % 多任务数据存储
cs.set_param('MultiTaskCondExecSysMsg', 'error');   % 多任务条件执行子系统
cs.set_param('MultiTaskRateTransMsg', 'error');   % 多任务数据传输
cs.set_param('SingleTaskRateTransMsg', 'none');   % 单任务数据传输
cs.set_param('TasksWithSamePriorityMsg', 'warning');   % 具有同等优先级的任务
cs.set_param('SigSpecEnsureSampleTimeMsg', 'warning');   % 强制应用 Signal Specification 模块指定的采样时间
cs.set_param('CheckMatrixSingularityMsg', 'none');   % 除以奇异矩阵
cs.set_param('IntegerOverflowMsg', 'warning');   % 溢出时绕回
cs.set_param('Int32ToFloatConvMsg', 'warning');   % 32 位整数到单精度浮点数转换
cs.set_param('ParameterDowncastMsg', 'error');   % 检测向下转换
cs.set_param('ParameterOverflowMsg', 'error');   % 检测溢出
cs.set_param('ParameterUnderflowMsg', 'none');   % 检测下溢
cs.set_param('ParameterPrecisionLossMsg', 'warning');   % 检测精度损失
cs.set_param('ParamSuppressDoubleToSinglePrecisionLossMsg', 'off');   % 不检测从双精度到单精度的转换
cs.set_param('ParamPrecisionLossAbsoluteDiffThreshold', '0.0');   % 绝对差阈值
cs.set_param('ParamPrecisionLossRelativeDiffThreshold', '0.0');   % 相对差阈值
cs.set_param('ParamOverflowErrorThreshold', 'OneBit');   % 误差阈值位
cs.set_param('ParameterTunabilityLossMsg', 'error');   % 检测可调性损失
cs.set_param('FixptConstUnderflowMsg', 'none');   % 检测下溢
cs.set_param('FixptConstOverflowMsg', 'none');   % 检测上溢
cs.set_param('FixptConstPrecisionLossMsg', 'none');   % 检测精度损失
cs.set_param('UnderSpecifiedDataTypeMsg', 'none');   % 未定数据类型
cs.set_param('UnnecessaryDatatypeConvMsg', 'none');   % 不必要的类型转换
cs.set_param('VectorMatrixConversionMsg', 'none');   % 向量/矩阵模块输入转换
cs.set_param('FcnCallInpInsideContextMsg', 'error');   % 上下文相关输入
cs.set_param('SignalLabelMismatchMsg', 'none');   % 信号标签不匹配
cs.set_param('UnconnectedInputMsg', 'none');   % 未连接的模块输入端口
cs.set_param('UnconnectedOutputMsg', 'none');   % 未连接的模块输出端口
cs.set_param('UnconnectedLineMsg', 'none');   % 未连接的信号线
cs.set_param('SFcnCompatibilityMsg', 'none');   % 需要升级 S-Function
cs.set_param('FrameProcessingCompatibilityMsg', 'error');   % 模块行为取决于信号的帧状态
cs.set_param('UniqueDataStoreMsg', 'none');   % 重复数据存储名称
cs.set_param('BusObjectLabelMismatch', 'warning');   % 元素名称不匹配
cs.set_param('RootOutportRequireBusObject', 'warning');   % 根 Outport 模块上未指定总线对象
cs.set_param('AssertControl', 'UseLocalSettings');   % Model Verification 模块启用
cs.set_param('AllowSymbolicDim', 'on');   % 允许符号维度设定
cs.set_param('ModelReferenceVersionMismatchMessage', 'none');   % Model 模块版本不匹配
cs.set_param('ModelReferenceIOMismatchMessage', 'none');   % 端口和参数不匹配
cs.set_param('UnknownTsInhSupMsg', 'warning');   % 未指定采样时间的可继承性
cs.set_param('ModelReferenceDataLoggingMessage', 'warning');   % 不支持的数据记录
cs.set_param('ModelReferenceNoExplicitFinalValueMsg', 'none');   % 模型参数没有显式最终值
cs.set_param('ModelReferenceSymbolNameMessage', 'warning');   % 最大标识符长度不足
cs.set_param('StateNameClashWarn', 'none');   % 状态名称冲突
cs.set_param('OperatingPointInterfaceChecksumMismatchMsg', 'warning');   % 工作点还原接口校验和不匹配
cs.set_param('NonCurrentReleaseOperatingPointMsg', 'error');   % 来自不同版本的工作点对象
cs.set_param('SubsystemReferenceDiagnosticForUnitTest', 'error');   % 缺失子系统引用的匹配单元测试时的行为
cs.set_param('InitInArrayFormatMsg', 'warning');   % 初始状态为数组
cs.set_param('StrictBusMsg', 'ErrorLevel1');   % 总线信号视为向量
cs.set_param('BusNameAdapt', 'WarnAndRepair');   % 修复总线选择
cs.set_param('NonBusSignalsTreatedAsBus', 'none');   % 非总线信号被视为总线信号
cs.set_param('SFUnusedDataAndEventsDiag', 'warning');   % 未使用的数据、事件、消息和函数
cs.set_param('SFUnexpectedBacktrackingDiag', 'error');   % 意外回溯
cs.set_param('SFInvalidInputDataAccessInChartInitDiag', 'warning');   % 图初始化中无效的输入数据访问
cs.set_param('SFNoUnconditionalDefaultTransitionDiag', 'error');   % 不存在无条件默认转移
cs.set_param('SFTransitionOutsideNaturalParentDiag', 'warning');   % 自然父级外的转移
cs.set_param('SFUnreachableExecutionPathDiag', 'warning');   % 不可达的执行路径
cs.set_param('SFUndirectedBroadcastEventsDiag', 'warning');   % 无向事件广播
cs.set_param('SFTransitionActionBeforeConditionDiag', 'warning');   % 在条件动作之前指定的转移动作
cs.set_param('SFOutputUsedAsStateInMooreChartDiag', 'error');   % 对摩尔图中输出的写前读
cs.set_param('SFTemporalDelaySmallerThanSampleTimeDiag', 'warning');   % 绝对时间时序值短于采样期间
cs.set_param('SFSelfTransitionDiag', 'warning');   % 叶状态的自转移
cs.set_param('SFExecutionAtInitializationDiag', 'warning');   % 存在输入事件时禁用了 '初始化时执行'
cs.set_param('IntegerSaturationMsg', 'warning');   % 溢出时饱和
cs.set_param('AllowedUnitSystems', 'all');   % 允许的单位制
cs.set_param('UnitsInconsistencyMsg', 'warning');   % 单位不一致消息
cs.set_param('AllowAutomaticUnitConversions', 'on');   % 允许自动单位转换
cs.set_param('ForceCombineOutputUpdateInSim', 'off');   % 为代码生成和仿真合并输出和更新方法
cs.set_param('UnderSpecifiedDimensionMsg', 'none');   % 欠定维度
cs.set_param('DebugExecutionForFMUViaOutOfProcess', 'off');   % FMU Import 模块
cs.set_param('ArithmeticOperatorsInVariantConditions', 'error');   % 变体条件中存在算术运算
cs.set_param('VariantConditionMismatch', 'none');   % 信号的源和目标的变体条件不匹配
cs.set_param('InheritVATfromSVC', 'warning');   % 从 Simulink.VariantControl 继承的变体激活时间
cs.set_param('VariantConfigNotUsedByTopModel', 'warning');   % 顶层模型未使用变体配置
cs.set_param('ParamWriterValidationControl', 'UseLocalSettings');   % Parameter Writer 模块验证

% Hardware Implementation
cs.set_param('ProdHWDeviceType', 'Intel->x86-64 (Windows64)');   % 生产设备供应商和类型
cs.set_param('ProdLongLongMode', 'off');   % 支持 long long
cs.set_param('ProdEqTarget', 'off');   % 测试硬件与生产硬件相同
cs.set_param('TargetHWDeviceType', 'MATLAB Host');   % 测试设备供应商和类型
cs.set_param('TargetLargestAtomicInteger', 'Char');   % 测试硬件中最大原子整数大小
cs.set_param('TargetLargestAtomicFloat', 'None');   % 测试硬件中最大原子浮点大小
cs.set_param('TargetPreprocMaxBitsSint', 32);   % C 预处理器中有符号整数的最大位数
cs.set_param('TargetPreprocMaxBitsUint', 32);   % C 预处理器中无符号整数的最大位数
cs.set_param('HardwareBoardFeatureSet', 'EmbeddedCoderHSP');   % 所选硬件板的功能集

% Model Referencing
cs.set_param('UpdateModelReferenceTargets', 'IfOutOfDateOrStructuralChange');   % 重新编译
cs.set_param('EnableRefExpFcnMdlSchedulingChecks', 'off');   % 为引用模型启用严格调度检查
cs.set_param('EnableParallelModelReferenceBuilds', 'off');   % 启用并行模型引用编译
cs.set_param('ParallelModelReferenceErrorOnInvalidPool', 'on');   % 对并行池执行一致性检查
cs.set_param('ModelReferenceNumInstancesAllowed', 'Multi');   % 每个顶层模型允许的实例总数
cs.set_param('PropagateVarSize', 'Infer from blocks in model');   % 传播可变大小信号的大小
cs.set_param('ModelDependencies', '');   % 模型依存关系
cs.set_param('ModelReferencePassRootInputsByReference', 'on');   % 为代码生成按值传递固定大小的标量根输入
cs.set_param('ModelReferenceMinAlgLoopOccurrences', 'off');   % 尽量减少出现人为代数环
cs.set_param('PropagateSignalLabelsOutOfModel', 'on');   % 将所有信号标签传播到模型之外
cs.set_param('SupportModelReferenceSimTargetCustomCode', 'off');   % 包含引用模型的自定义代码
cs.set_param('UseModelRefSolver', 'off');   % 引用模型时使用局部求解器

% Simulation Target
cs.set_param('SimCustomSourceCode', '');   % 其他代码
cs.set_param('SimUserSources', '');   % 源文件
cs.set_param('SimCustomHeaderCode', '');   % 包含头文件
cs.set_param('SimCustomInitializer', '');   % 初始化代码
cs.set_param('SimCustomTerminator', '');   % 终止代码
cs.set_param('SimReservedNameArray', []);   % 保留名称
cs.set_param('SimUserIncludeDirs', '');   % 包含目录
cs.set_param('SimUserLibraries', '');   % 库
cs.set_param('SimUserDefines', '');   % 宏定义
cs.set_param('SimCustomCompilerFlags', '');   % 编译器标志
cs.set_param('SimCustomLinkerFlags', '');   % 链接器标志
cs.set_param('SFSimEnableDebug', 'off');   % 允许在仿真期间设置断点
cs.set_param('SFSimEcho', 'on');   % 回显不带分号的表达式的输出
cs.set_param('SimCtrlC', 'on');   % 按 Ctrl+C 中断
cs.set_param('SimIntegrity', 'on');   % 启用内存完整性检查
cs.set_param('SimParseCustomCode', 'on');   % 导入自定义代码
cs.set_param('SimDebugExecutionForCustomCode', 'off');   % 在单独进程中仿真自定义代码
cs.set_param('SimAnalyzeCustomCode', 'off');   % 启用自定义代码分析
cs.set_param('SimGenImportedTypeDefs', 'off');   % 为导入的总线和枚举类型生成 typedef
cs.set_param('CompileTimeRecursionLimit', 50);   % MATLAB 函数的编译时递归限制
cs.set_param('EnableRuntimeRecursion', 'on');   % 为 MATLAB 函数启用运行时递归
cs.set_param('EnableImplicitExpansion', 'on');   % 在 MATLAB 函数中启用隐式扩展
cs.set_param('MATLABDynamicMemAlloc', 'off');   % 在 MATLAB 函数中使用动态内存分配
cs.set_param('GPUAcceleration', 'off');   % GPU 加速
cs.set_param('UsePrecompiledLibraries', 'Prefer');   % 对 MATLAB 函数使用预编译库
cs.set_param('LegacyBehaviorForPersistentVarInContinuousTime', 'off');   % 允许连续时间 MATLAB 函数写入初始化的持久变量
cs.set_param('CustomCodeFunctionArrayLayout', []);   % 例外函数...
cs.set_param('DefaultCustomCodeFunctionArrayLayout', 'NotSpecified');   % 默认函数数组布局
cs.set_param('CustomCodeUndefinedFunction', 'FilterOut');   % 未定义的函数和变量处理
cs.set_param('CustomCodeGlobalsAsFunctionIO', 'off');   % 自动将全局变量推断为函数接口
cs.set_param('DefaultCustomCodeDeterministicFunctions', 'None');   % 确定性函数
cs.set_param('SimHardwareAcceleration', 'generic');   % 硬件加速
cs.set_param('SimTargetLang', 'C');   % 语言

% Code Generation
cs.set_param('GenerateGPUCode', 'None');   % 生成 GPU 代码
cs.set_param('CodeReplacementLibrary', 'None');   % 代码替换库
cs.set_param('ArrayLayout', 'Column-major');   % 数组布局
cs.set_param('UseOperatorNewForModelRefRegistration', 'off');   % 对模型模块实例化使用动态内存分配
cs.set_param('TLCOptions', '');   % TLC 命令行选项
cs.set_param('GenerateMakefile', 'on');   % 生成联编文件
cs.set_param('RTWCompilerOptimization', 'off');   % 编译器优化级别
cs.set_param('GenCodeOnly', 'off');   % 仅生成代码
cs.set_param('MakeCommand', 'make_rtw');   % make 命令
cs.set_param('PackageGeneratedCodeAndArtifacts', 'on');   % 代码和工件打包
cs.set_param('PackageName', '');   % Zip 文件名
cs.set_param('TemplateMakefile', 'RTW.MSVCBuild');   % 模板联编文件
cs.set_param('PostCodeGenCommand', '');   % 代码生成之后执行的命令
cs.set_param('GenerateReport', 'on');   % 创建代码生成报告
cs.set_param('RTWVerbose', 'on');   % 详尽编译
cs.set_param('RetainRTWFile', 'off');   % 保留 .rtw 文件
cs.set_param('ProfileTLC', 'off');   % 探查 TLC
cs.set_param('TLCDebug', 'off');   % 生成代码时启动 TLC 调试器
cs.set_param('TLCCoverage', 'off');   % 生成代码时启动 TLC 覆盖率报告
cs.set_param('TLCAssert', 'off');   % 启用 TLC 断言
cs.set_param('BuiltinFFTWCallback', 'off');   % 内置 FFTW 库回调
cs.set_param('RTWUseSimCustomCode', 'off');   % 使用与仿真目标相同的自定义代码设置
cs.set_param('CustomSourceCode', '');   % 其他代码
cs.set_param('CustomHeaderCode', '');   % 包含头文件
cs.set_param('CustomInclude', '');   % 包含目录
cs.set_param('CustomSource', '');   % 源文件
cs.set_param('CustomLibrary', '');   % 库
cs.set_param('CustomDefine', '');   % 宏定义
cs.set_param('CustomBLASCallback', '');   % 自定义 BLAS 库回调
cs.set_param('CustomLAPACKCallback', '');   % 自定义 LAPACK 库回调
cs.set_param('CustomFFTCallback', '');   % 自定义 FFT 库回调
cs.set_param('CustomInitializer', '');   % 初始化代码
cs.set_param('CustomTerminator', '');   % 终止代码
cs.set_param('LaunchReport', 'on');   % 自动打开报告
cs.set_param('CodeExecutionProfiling', 'off');   % 测量任务执行时间
cs.set_param('RemoveFixptWordSizeChecks', 'off');   % 不生成定点字长检查
cs.set_param('ObjectivePriorities', []);   % 优先目标
cs.set_param('CheckMdlBeforeBuild', 'Off');   % 生成代码前检查模型
cs.set_param('DLTargetLibrary', 'none');   % 深度学习库
cs.set_param('DLLearnablesCompression', 'None');   % 可学习参数压缩
cs.set_param('GenerateComments', 'on');   % 包括注释
cs.set_param('ForceParamTrailComments', 'on');   % 为 '模型默认' 存储类提供详尽注释
cs.set_param('MaxIdLength', 95);   % 最大标识符长度
cs.set_param('ShowEliminatedStatement', 'on');   % 显示已消除模块
cs.set_param('SimulinkBlockComments', 'on');   % Simulink 模块注释
cs.set_param('StateflowObjectComments', 'on');   % Stateflow 对象注释
cs.set_param('MATLABSourceComments', 'on');   % MATLAB 源代码作为注释
cs.set_param('UseSimReservedNames', 'off');   % 使用与仿真目标相同的保留名称
cs.set_param('ReservedNameArray', []);   % 保留名称
cs.set_param('EnumMemberNameClash', 'error');   % 重复的枚举成员名称
cs.set_param('TargetLibSuffix', '');   % 应用于目标库名称的后缀
cs.set_param('TargetPreCompLibLocation', '');   % 预编译的库位置
cs.set_param('TargetLangStandard', 'C++11 (ISO)');   % 语言标准
cs.set_param('UtilityFuncGeneration', 'Auto');   % 共享代码放置
cs.set_param('MultiwordLength', 2048);   % 最大字长
cs.set_param('DynamicStringBufferSize', 256);   % 动态大小字符串的缓冲区大小(以字节为单位)
cs.set_param('GenerateFullHeader', 'on');   % 生成完整文件前注
cs.set_param('InferredTypesCompatibility', 'off');   % 在 rtwtypes.h 中创建预处理器指令。
cs.set_param('CombineOutputUpdateFcns', 'on');   % 单一输出/更新函数
cs.set_param('MatFileLogging', 'off');   % MAT 文件记录
cs.set_param('SupportNonFinite', 'on');   % 支持非有限数
cs.set_param('LUTObjectStructOrderExplicitValues', 'Size,Breakpoints,Table');   % 显式值设定的 LUT 对象结构体顺序
cs.set_param('LUTObjectStructOrderEvenSpacing', 'Size,Breakpoints,Table');   % 等间距设定的 LUT 对象结构体顺序
cs.set_param('InstructionSetExtensions', {'SSE2'});   % 利用目标硬件指令集扩展
cs.set_param('OptimizeReductions', 'off');   % 优化归约
cs.set_param('HeaderGuardPrefix', '');   % 头文件防卫式声明前缀
cs.set_param('LogToMDFFile', 'off');   % 将信号记录到 MDF 文件
cs.set_param('ExtMode', 'off');   % 外部模式
cs.set_param('ExtModeTransport', 0);   % 传输层
cs.set_param('ExtModeMexFile', 'ext_comm');   % MEX 文件名
cs.set_param('ExtModeStaticAlloc', 'off');   % 静态内存分配
cs.set_param('GenerateDestructor', 'on');   % 生成析构函数
cs.set_param('IncludeModelTypesInModelClass', 'on');   % 在模型类中包含模型类型
cs.set_param('ExtModeTesting', 'off');   % 外部模式测试
cs.set_param('ExtModeMexArgs', '');   % MEX 文件参数
cs.set_param('ExtModeIntrfLevel', 'Level1');   % 外部模式接口级别
cs.set_param('RTWCAPISignals', 'on');   % 生成用于信号的 C API
cs.set_param('RTWCAPIParams', 'on');   % 生成用于参数的 C API
cs.set_param('RTWCAPIStates', 'on');   % 生成用于状态的 C API
cs.set_param('RTWCAPIRootIO', 'on');   % 生成用于根级 I/O 的 C API
cs.set_param('MultiInstanceErrorCode', 'Error');   % 多实例代码错误诊断

% Simulink Coverage
cs.set_param('CovEnable', 'off');   % 启用覆盖率分析
cs.set_param('RecordCoverage', 'off');   % 记录此模型的覆盖率
cs.set_param('CovModelRefEnable', 'off');   % 记录引用模型的覆盖率

% HDL Coder
try 
	cs_componentCC = hdlcoderconfigsetup(cs);

catch ME
	warning('Simulink:ConfigSet:AttachComponentError', '%s', ME.message);
end