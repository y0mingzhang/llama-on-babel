from transformers import AutoTokenizer
import transformers
import torch

model = "meta-llama/Llama-2-7b-hf"

prefixes = [
    "Based on longstanding prior ACL practice, all papers in the program (oral or poster) must",
    "Llama 2 is a family of state-of-the-art open-access large language models released by Meta"
]

tokenizer = AutoTokenizer.from_pretrained(model)
pipeline = transformers.pipeline(
    "text-generation",
    model=model,
    torch_dtype=torch.float16,
    device_map="auto",
)

generations = pipeline(
    prefixes,
    do_sample=True,
    top_p=0.6,
    eos_token_id=tokenizer.eos_token_id,
    max_new_tokens=100,
)

for prefix, generation in zip(prefixes, generations):
    print("PREFIX:", prefix)
    print("GENERATION:", generation[0]["generated_text"], end='\n\n')
