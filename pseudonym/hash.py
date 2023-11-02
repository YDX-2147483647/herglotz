from hashlib import sha256


def hash(name: str) -> str:
    """按 UTF-8 编码来 SHA256"""
    return sha256(name.encode("utf-8")).hexdigest()
