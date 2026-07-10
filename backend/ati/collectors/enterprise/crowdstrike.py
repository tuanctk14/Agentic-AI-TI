"""crowdstrike enterprise collector - key-activated stub."""
import logging
from ati.config import settings
logger = logging.getLogger("ati.collectors.enterprise.crowdstrike")

async def run_collection() -> dict:
    return {"status": "inactive", "reason": "crowdstrike: enterprise license required - add key to .env to activate"}
