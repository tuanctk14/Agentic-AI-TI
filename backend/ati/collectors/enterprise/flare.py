"""flare enterprise collector - key-activated stub."""
import logging
from ati.config import settings
logger = logging.getLogger("ati.collectors.enterprise.flare")

async def run_collection() -> dict:
    return {"status": "inactive", "reason": "flare: enterprise license required - add key to .env to activate"}
