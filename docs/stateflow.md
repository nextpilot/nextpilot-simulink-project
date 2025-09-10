在Stateflow控制状态转移除了常规的事件和条件表达式，还有以下几种方式：

- 使用临时逻辑，比如after，before，at，every等
- 使用检测变量变化，比如hasChanged、crossing等
- 使用隐式事件，比如change、enter、exit等，注意这个是事件，不是条件表达式，也就是事件发生后立即激活对应的状态

一个完整的转移语法是：

> Event[Condition]{Condition Actions}/{Transition Actions}

## [使用临时逻辑控制图执行（Control Chart Execution by Using Temporal Logic）](https://ww2.mathworks.cn/help/releases/R2024b/stateflow/ug/using-temporal-logic-in-state-actions-and-transitions.html)

Temporal logic controls the execution of a chart in terms of time. In state actions and transitions, you can use two types of temporal logic:

- Event-based temporal logic tracks recurring events. You can use any explicit or implicit event as a base event.

- Absolute-time temporal logic tracks the elapsed time since a state became active.

### after(n, X)

当关联state激活的情况下，`X` 发生 `n` 次之后返回 `true`，其中X可以为：`事件、tick、sec、msec、usec`等

```
% 在state中使用
on after(3,E):
   disp("ON");

% 在转移中使用
after(5,E)[temp > 98.6]

```

### at(n, X)

当关联state激活当前情况下， X 正好发生 n 次时返回 true，其中X可以为：事件、tick、sec

### before(n, X)

当关联state激活当前情况下， X 发生少于 n 次时返回 true，其中X可以为：事件、tick、sec、msec、usec

### every(n, X)

当关联state激活当前情况下， X 每发生 n 次返回 true，其中X可以为：事件、tick、sec

### temporalCount(X)

当关联state激活当前情况下， 统计 X 发生的次数，其中X可以为：事件、tick、sec、msec、usec

### elapsed(sec)或者et

等效于temporalCount(sec)，当关联state激活当前情况下，返回state激活时间

### count(C)

当关联state激活当前情况下， 返回表达式 C 为true 的总次数

### duration(C, X)

当关联state激活当前情况下， 返回表达式 C 为true 的总时间，其中X可以 sec、msec、usec

## [检测变量和表达式值变化（Detect Changes in Data and Expression Values）](https://ww2.mathworks.cn/help/releases/R2024b/stateflow/ug/detecting-changes-in-data-values.html)

> 注意：在MATLAB 语言的Stateflow中hasChanged等只能用来检测input变量，无法检测输出和局部变量
>
> 另外变量变化检测hasChanged和隐式事件change的区别：
>
> 1、hasChanged在MATLAB语言的stateflow中只能应用于输入变量，change可以用于局部变量
>
> 2、hasChanged只是一个表达式，在每次运行到该state的时候才会判断，change是事件触发（相当于函数调用），当修改事件发生会立即激活对应的state

### 变化检测

- tf = hasChanged(data_name)，当变量data_name发生改变，则返回true
- tf = hasChangedFrom(data_name,value)，当变量data_name由value变为其他的值，则返回true
- tf = hasChangedTo(data_name,value)，当变量data_name由其他值变为value，则返回true

### 边缘检测

- tf = crossing(expression)，当表达式 expression 的值过0，则返回true
- tf = falling(expression)，当表达式 expression 的值减小，则返回true
- tf = rising(expression)，当表达式 expression 的值增大，则返回true

## [使用隐式事件控制图的行为（Control Chart Behavior by Using Implicit Events）](https://ww2.mathworks.cn/help/releases/R2024b/stateflow/ug/using-implicit-events.html)

Implicit events are built-in events that occur during chart execution when:

- The chart wakes up.
- The chart enters a state and the state becomes active.
- The chart exits a state and the state becomes inactive.
- The chart assigns a value to an internal data object.

These events are implicit because you do not define or trigger them explicitly. Implicit events are children of the chart in which they occur and are visible only in the parent chart.

### change/chg(data_name)

Generates an implicit local event when the chart sets the value of the variable data_name.

### enter/en(state_name)

Generates an implicit local event when the specified state state_name becomes active.

### exit/ex(state_name)

Generates an implicit local event when the specified state state_name becomes inactive.

## 检查状态是否激活（Check State Activity by Using the in Operator）

To check if a state is active in a given time step, call the in operator in state and transition actions. The in operator takes a qualified state name state_name and returns a Boolean output. If state state_name is active, in returns a value of 1 (true). Otherwise, in returns a value of 0 (false).

```
in(state_name)
```
