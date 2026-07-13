#!/usr/bin/env python3
"""Setup script for CLAW_PHISH_v2"""

from setuptools import setup, find_packages
import os
import re

# Read version from main file
with open('src/main.py', 'r', encoding='utf-8') as f:
    content = f.read()
    version_match = re.search(r'VERSION\s*=\s*["\']([^"\']+)["\']', content)
    version = version_match.group(1) if version_match else '2.0.0'
    author_match = re.search(r'AUTHOR\s*=\s*["\']([^"\']+)["\']', content)
    author = author_match.group(1) if author_match else 'Ian Carter Kulani'

with open('README.md', 'r', encoding='utf-8') as f:
    long_description = f.read()

setup(
    name='claw_phish_v2',
    version=version,
    author=author,
    author_email='claw.phish@security.local',
    description='Ultimate Cybersecurity Command & Control Platform',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/iancarterkulani/claw_phish_v2',
    packages=find_packages(),
    classifiers=[
        'Development Status :: 4 - Beta',
        'Intended Audience :: Information Technology',
        'Intended Audience :: Education',
        'Intended Audience :: Developers',
        'License :: Other/Proprietary License',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
        'Programming Language :: Python :: 3.11',
        'Programming Language :: Python :: 3.12',
        'Topic :: Security',
        'Topic :: System :: Networking :: Monitoring',
        'Topic :: System :: Networking :: Firewalls',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Software Development :: Testing :: Traffic Generation',
        'Environment :: Console',
        'Environment :: Web Environment',
        'Framework :: Flask',
        'Operating System :: MacOS',
        'Operating System :: Microsoft :: Windows',
        'Operating System :: POSIX :: Linux',
    ],
    keywords='cybersecurity, c2, command-and-control, security-tools, pentesting, ' \
             'phishing, keylogger, traffic-generation, ssh, dos, network-monitoring, ' \
             'social-engineering, discord-bot, telegram-bot, slack-bot, web-dashboard',
    python_requires='>=3.9',
    install_requires=[
        'requests>=2.31.0',
        'psutil>=5.9.6',
        'dnspython>=2.4.2',
        'cryptography>=41.0.7',
        'Flask>=3.0.0',
        'Flask-SocketIO>=5.3.6',
        'Flask-CORS>=4.0.0',
        'paramiko>=3.3.1',
        'discord.py>=2.3.2',
        'Telethon>=1.34.0',
        'slack-sdk>=3.27.0',
        'matplotlib>=3.8.0',
        'seaborn>=0.13.0',
        'reportlab>=4.0.8',
        'beautifulsoup4>=4.12.2',
        'scapy>=2.5.0',
        'pynput>=1.7.6',
    ],
    extras_require={
        'dev': [
            'pytest>=7.4.3',
            'pytest-cov>=4.1.0',
            'black>=23.11.0',
            'flake8>=6.1.0',
            'mypy>=1.7.0',
            'sphinx>=7.2.6',
        ],
        'ai': [
            'tensorflow>=2.14.0',
            'transformers>=4.36.0',
        ],
        'windows': [
            'pywin32>=306',
            'wmi>=1.5.1',
        ],
        'mac': [
            'pyobjc-framework-Cocoa>=9.2',
            'pyobjc-framework-Quartz>=9.2',
        ],
    },
    entry_points={
        'console_scripts': [
            'claw-phish=main:main',
        ],
    },
    package_data={
        'claw_phish_v2': [
            'config/*.json',
            'web_templates/*.html',
            'phishing_templates/*.html',
            'email_templates/*.html',
        ],
    },
    include_package_data=True,
    zip_safe=False,
)