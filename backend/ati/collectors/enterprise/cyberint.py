"""cyberint enterprise collector - key-activated stub."""
import logging
from ati.config import settings
logger = logging.getLogger("ati.collectors.enterprise.cyberint")

async def run_collection() -> dict:
    return {"status": "inactive", "reason": "cyberint: enterprise license required - add key to .env to activate"}
