# 配置 Agent 指南

## 一、什么是 Agent

Agent（智能体）是指能够**感知环境、自主决策并执行动作**的 AI 系统。它不仅仅是一个对话模型，而是具备以下能力的程序：

- **规划能力**：将复杂任务拆解为可执行的步骤
- **工具调用**：调用外部 API、数据库、搜索引擎等
- **记忆能力**：保存上下文和历史交互
- **自主执行**：根据反馈迭代调整策略

## 二、Agent 架构组成

| 组件 | 作用 |
|------|------|
| LLM 核心 | 负责推理、决策和生成 |
| 工具集（Tools） | 扩展 Agent 能力，如搜索、代码执行、文件操作 |
| 记忆（Memory） | 短期记忆（上下文） + 长期记忆（向量数据库） |
| 规划器（Planner） | 任务分解与执行计划生成 |
| 调度器（Scheduler） | 控制执行流程与循环 |

## 三、主流框架选型

| 框架 | 特点 | 适合场景 |
|------|------|----------|
| LangChain | 生态丰富，组件齐全 | 快速原型开发 |
| AutoGPT | 自主任务执行 | 自动化任务 |
| CrewAI | 多 Agent 协作 | 角色分工场景 |
| OpenAI Assistants API | 官方支持，集成度高 | OpenAI 生态 |
| MetaGPT | 软件公司角色模拟 | 软件开发自动化 |

## 四、基础配置示例

### 1. 使用 LangChain 构建简单 Agent

```python
from langchain.agents import initialize_agent, AgentType
from langchain.llms import OpenAI
from langchain.tools import DuckDuckGoSearchRun

# 初始化 LLM
llm = OpenAI(temperature=0, api_key="your-api-key")

# 定义工具
tools = [DuckDuckGoSearchRun()]

# 创建 Agent
agent = initialize_agent(
    tools,
    llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)

# 执行任务
agent.run("今天北京天气怎么样？适合穿什么？")
```

### 2. 使用环境变量管理配置

```bash
# .env 文件
OPENAI_API_KEY=sk-xxxxxxxx
ANTHROPIC_API_KEY=sk-ant-xxxxxxxx
SERPAPI_API_KEY=xxxxxxxx
MODEL_NAME=gpt-4o

# Python 中加载
from dotenv import load_dotenv
load_dotenv()
```

## 五、工具（Tools）配置

### 自定义工具

```python
from langchain.tools import BaseTool
from pydantic import BaseModel, Field

class CalculatorInput(BaseModel):
    expression: str = Field(description="数学表达式，如 '2+3*4'")

class CalculatorTool(BaseTool):
    name = "calculator"
    description = "用于计算数学表达式的结果"
    args_schema = CalculatorInput

    def _run(self, expression: str) -> str:
        try:
            result = eval(expression)
            return str(result)
        except Exception as e:
            return f"计算错误: {e}"
```

### 常用内置工具

| 工具 | 功能 |
|------|------|
| SerpAPI | 联网搜索 |
| Wikipedia | 百科查询 |
| Python REPL | 执行 Python 代码 |
| SQL Database | 数据库查询 |
| Requests | HTTP 请求 |

## 六、记忆（Memory）配置

### 对话记忆

```python
from langchain.memory import ConversationBufferMemory

memory = ConversationBufferMemory(
    memory_key="chat_history",
    return_messages=True
)
```

### 向量记忆（长期记忆）

```python
from langchain.vectorstores import Chroma
from langchain.embeddings import OpenAIEmbeddings

vectorstore = Chroma(
    collection_name="agent_memory",
    embedding_function=OpenAIEmbeddings()
)

# 存储记忆
vectorstore.add_texts(["用户喜欢简洁的代码风格"])

# 检索记忆
results = vectorstore.similarity_search("用户偏好", k=3)
```

## 七、提示词模板（System Prompt）

```
你是一个智能助手，具备以下能力：
1. 使用搜索工具获取最新信息
2. 执行代码验证结果
3. 记住用户的历史偏好

工作原则：
- 不确定时主动搜索确认
- 多步骤任务先规划再执行
- 遇到错误时分析并尝试替代方案
- 回复简洁清晰，适当使用代码示例
```

## 八、最佳实践

1. **最小权限**：工具调用时限制权限范围，避免误操作
2. **超时控制**：设置工具调用的超时时间，防止无限循环
3. **错误处理**：捕获异常并提供有意义的反馈
4. **日志记录**：记录 Agent 的每一步决策，便于调试
5. **成本控制**：设置最大迭代次数，避免 API 费用失控
6. **人工审核**：高风险操作（如文件删除、数据库写入）需人工确认

## 九、部署方式

| 方式 | 优点 | 缺点 |
|------|------|------|
| 本地运行 | 数据安全，成本低 | 性能受限 |
| 云服务器 | 弹性扩展，24h 在线 | 需运维管理 |
| Serverless | 按需付费，免运维 | 冷启动延迟 |
| 容器化 | 环境一致，易迁移 | 需 Docker 知识 |
